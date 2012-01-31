---
title: Connecting to a Database
layout: default
---

To connect to a database, you need to tell Tosa what JDBC connection string to use.
In Ronin, this is done in `config.RoninConfig`:

    if(m == DEVELOPMENT) {
      AdminConsole.start()
      db.model.Database.JdbcUrl = "jdbc:h2:file:runtime/h2/devdb"
    } else if( m == TESTING ) {
      db.model.Database.JdbcUrl = "jdbc:h2:file:runtime/h2/testdb"
    } else if( m == STAGING ) {
      db.model.Database.JdbcUrl = "jdbc:h2:file:runtime/h2/stagingdb"
    } else if( m == PRODUCTION ) {
      db.model.Database.JdbcUrl = "jdbc:h2:file:runtime/h2/proddb"
    }

(Modify the username and password as appropriate.) Note that relative URLs are
resolved relative to where you launch Gosu from, not relative to the .dbc file
itself.  Also note that different database strings are used depending on the mode
of the application, which is a common pattern.

Next, create a file with the extension ".ddl" in your source code.  This file
contains the database schema in standard [DDL][1] format.  In Ronin, this will
go in the `db` package, by convention.

That's it! You can now access the types in your
database. The package in which those types live is determined by the location
of the .ddl file in your classpath, plus the name of the .ddl file. So if your
file is named "test.ddl", and it's in a folder called "db", the types will be
in a package called `db.test`.

Note: if you're using either H2 or MySQL, Tosa will automatically
initialize the JDBC connector for you. If you're using any other database,
though, you'll need to set a system property to let Tosa know what class
serves as the connector for your database. The name of the property is
`db.driver.[database name]`, where `[database name]` is the same as what
immediately follows "`jdbc:`" in the JDBC URL, and the value of the property
should be the fully qualified class name of the connector class. Consult your
database's documentation for more information.

Next, we'll learn how to [add, update, and delete entities](Adding,-Updating,-and-Deleting.html).

  [1]: http://en.wikipedia.org/wiki/Data_Definition_Language