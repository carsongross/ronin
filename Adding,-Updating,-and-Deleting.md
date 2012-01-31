---
title: Adding, Updating, and Deleting
layout: default
---

## Adding an entity

To add a new entity to your database, create an instance of the entity type,
set whatever properties you wish to set, and call the `update()` method. For
example, if you have a table "`Person`" with columns "`Name`" and
"`PhoneNumber`":

{% highlight js %}
    var p = new Person()
    p.Name = "Bob"
    p.PhoneNumber = "555-1212"
    p.update()
{% endhighlight %}

Or, using Gosu's object initializer syntax:

{% highlight js %}
    var p = new Person() {:Name = "Bob", :PhoneNumber = "555-1212"}
    p.update()
{% endhighlight %}

## Updating an entity

Updating an existing entity is the same as creating a new entity, except that
instead of constructing a new instance, you retrieve it using one of the
[query methods][3] available on the entity type:

{% highlight js %}
    var p = Person.fromId(5)
    p.Name = "Fred"
    p.update()
{% endhighlight %}

## Deleting an entity

You can delete an entity from the database entirely by calling its delete()
method:

{% highlight js %}
    var p = Person.fromId(5)
    p.delete()
{% endhighlight %}

Now let's see how to [retrieve entites from the database](Retrieving-Data.html).
