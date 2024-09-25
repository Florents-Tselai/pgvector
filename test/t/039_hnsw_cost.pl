use strict;
use warnings FATAL => 'all';
use PostgreSQL::Test::Cluster;
use PostgreSQL::Test::Utils;
use Test::More;

my @dims = (384, 1536);
my $limit = 10;

# Initialize node
my $node = PostgreSQL::Test::Cluster->new('node');
$node->init;
$node->start;

$node->safe_psql("postgres", "CREATE EXTENSION vector;");

for my $dim (@dims)
{
	my $array_sql = join(",", ('random()') x $dim);
	my $n = $dim == 384 ? 2000 : 1000;

	# Create table and index
	$node->safe_psql("postgres", "CREATE TABLE tst (i int4, v vector($dim));");
	$node->safe_psql("postgres",
		"INSERT INTO tst SELECT i, ARRAY[$array_sql] FROM generate_series(1, $n) i;"
	);
	$node->safe_psql("postgres", "CREATE INDEX idx ON tst USING hnsw (v vector_l2_ops);");
	$node->safe_psql("postgres", "ANALYZE tst;");

	# Generate query
	my @r = ();
	for (1 .. $dim)
	{
		push(@r, rand());
	}
	my $query = "[" . join(",", @r) . "]";

	my $explain = $node->safe_psql("postgres", qq(
		EXPLAIN ANALYZE SELECT i FROM tst ORDER BY v <-> '$query' LIMIT $limit;
	));
	like($explain, qr/Index Scan using idx/);

	$node->safe_psql("postgres", "DROP TABLE tst;");
}

done_testing();