JSONConverter
=============



Converts hash to/from JSON


.. toctree::
   :maxdepth: 3
   :titlesonly:


   

   

   

   




Constants
---------





Files
-----



  * `lib/neo4j/shared/type_converters.rb:117 <https://github.com/neo4jrb/neo4j/blob/master/lib/neo4j/shared/type_converters.rb#L117>`_





Methods
-------



.. _`Neo4j/Shared/TypeConverters/JSONConverter.convert_type`:

**.convert_type**
  

  .. hidden-code-block:: ruby

     def convert_type
       JSON
     end



.. _`Neo4j/Shared/TypeConverters/JSONConverter.db_type`:

**.db_type**
  

  .. hidden-code-block:: ruby

     def db_type
       String
     end



.. _`Neo4j/Shared/TypeConverters/JSONConverter.to_db`:

**.to_db**
  

  .. hidden-code-block:: ruby

     def to_db(value)
       value.to_json
     end



.. _`Neo4j/Shared/TypeConverters/JSONConverter.to_ruby`:

**.to_ruby**
  

  .. hidden-code-block:: ruby

     def to_ruby(value)
       JSON.parse(value, quirks_mode: true)
     end





