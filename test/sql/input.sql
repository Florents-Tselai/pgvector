SELECT '[1,2,3]'::vector;
SELECT '[-1,-2,-3]'::vector;
SELECT '[1.,2.,3.]'::vector;
SELECT ' [ 1,  2 ,    3  ] '::vector;
SELECT '[1.23456]'::vector;
SELECT '[hello,1]'::vector;
SELECT '[NaN,1]'::vector;
SELECT '[Infinity,1]'::vector;
SELECT '[-Infinity,1]'::vector;
SELECT '[1.5e38,-1.5e38]'::vector;
SELECT '[1.5e+38,-1.5e+38]'::vector;
SELECT '[1.5e-38,-1.5e-38]'::vector;
SELECT '[4e38,1]'::vector;
SELECT '[1,2,3'::vector;
SELECT '[1,2,3]9'::vector;
SELECT '1,2,3'::vector;
SELECT ''::vector;
SELECT '['::vector;
SELECT '[,'::vector;
SELECT '[]'::vector;
SELECT '[1,]'::vector;
SELECT '[1a]'::vector;
SELECT '[1,,3]'::vector;
SELECT '[1, ,3]'::vector;

SELECT '[1,2,3]'::vector(3);
SELECT '[1,2,3]'::vector(2);
SELECT '[1,2,3]'::vector(3, 2);
SELECT '[1,2,3]'::vector('a');
SELECT '[1,2,3]'::vector(0);
SELECT '[1,2,3]'::vector(16001);

SELECT unnest('{"[1,2,3]", "[4,5,6]"}'::vector[]);
SELECT '{"[1,2,3]"}'::vector(2)[];
