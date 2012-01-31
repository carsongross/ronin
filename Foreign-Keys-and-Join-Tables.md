---
title: Foreign Keys and Join Tables
layout: default
---

Tosa will generate links and collection properties between entity objects,
assuming you've set up your foreign keys and/or join tables according to the
schema guidelines.

For example, say you have tables "`Person`" and "`Company`", and Gosu
variables "`p`" and "`c`" containing a `Person` and a `Company`. If the table
"`Person`" has a FK named "`Employer_Company_id`", then `p.Employer` will
fetch and return the `Company` object which the FK points to (or `null` if the
FK is null), and `c.Persons` will return a `List` of all the `Person` objects
whose FK points to that `Company`. (If the FK column was named simply
"`Company_id`", then the property on `Person` would be `p.Company`.)

If instead you have a join table named "`Employment_join_Company_Person`" (so
that a `Person` could have multiple employers), `p.Employment` would return
the `Companies` linked to that `Person` through the join table, and
`c.Employment` would do likewise for a `Company`. If the join table was named
"`join_Company_Person`", the properties would be `c.Persons` and `p.Companys`.
(Tosa does not attempt to be grammatically correct with its generated
property names.) For a self-join table, such as
"`Relatives_join_Person_Person`", the generated property would be
`p.Relatives` for both sides.

## Modifying FKs and join tables

The `List` objects returned by join table properties can be modified in order
to update the join table. For example:

{% highlight js %}
    var bob = Person.fromId(5)
    var fred = Person.fromId(7)
    bob.Relatives.add(fred)
{% endhighlight %}

will create an entry in the "`Relatives_join_Person_Person`" table linking Bob
to Fred.

This is not true of FK relationships. The `List` returned by `c.Persons` in
the first example above does not persist any changes to the database. Instead,
modifications should be made to the foreign key itself. To add a `Person` to a
`Company`:

{% highlight js %}
    p.Company = c
{% endhighlight %}

and to remove it:

{% highlight js %}
    p.Company = null
{% endhighlight %}

Finally, let's look at [transactions in Tosa](Transactions.html).
