CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT b.name
  FROM parents as p, dogs as a, dogs as b
  WHERE b.name = p.child and p.parent = a.name
  ORDER BY a.height DESC;

-- The size of each dog
CREATE TABLE size_of_dogs AS
      SELECT d.name as name, s.size as size
      FROM dogs as d, sizes as s
      WHERE d.height > s.min and d.height <= s.max; 
-- Filling out this helper table is optional
CREATE TABLE siblings AS
      SELECT a.name as first_name, b.name as second_name, a.size as size
      FROM size_of_dogs as a, size_of_dogs as b, parents as a_p, parents as b_p
      WHERE a.size = b.size and a.name < b.name and a.name = a_p.child and b.name = b_p.child and a_p.parent = b_p.parent;
-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
      SELECT "The two siblings, " || first_name || " and " || second_name || ", have the same size: " || size
      FROM siblings;

-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE avg_height AS
      SELECT fur, AVG(height) as avg_height
      FROM dogs
      GROUP BY fur;

CREATE TABLE low_variance AS
      SELECT dogs.fur, MAX(height) - MIN(height)
      FROM dogs, avg_height
      WHERE dogs.fur = avg_height.fur
      GROUP BY dogs.fur
      HAVING COUNT(*) = SUM(CASE WHEN
        	      height >= avg_height * 0.7 and height <= avg_height * 1.3
              THEN 1 ELSE 0 END);     
