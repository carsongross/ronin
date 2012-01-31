---
title: Your First Ronin App
layout: default
---

Make sure you've [downloaded everything you need](Ronin.html).  Run the following vark script from the command line:

`vark -f http://ronin-web.org/init.vark init -name my_app`

Replace `my_app` with whatever name you would like your application to have.  This will create a ronin application in the `my_app` directory.

Now you should be able to start up your server by switching into the `my_app`
directory and running the `server` target with Aardvark:

    [tmp]$ cd my_app/
    [my_app]$ vark server
    Buildfile: /private/tmp/my_app/build.vark
    [19:58:38] Done parsing Aardvark buildfile in 998 ms
    
    server:
    Starting server in socket debug mode at 8088
         [java] The args attribute is deprecated. Please use nested arg elements.
         [java] The jvmargs attribute is deprecated. Please use nested jvmarg elements.
         [java] Listening for transport dt_socket at address: 8088
         [java] 42 [main] INFO org.eclipse.jetty.util.log - jetty-8.0.0.M2
         [java] 319 [main] INFO org.eclipse.jetty.util.log - NO JSP Support for /, did not find org.apache.jasper.servlet.JspServlet
         [java] 482 [main] INFO org.eclipse.jetty.util.log - Started SelectChannelConnector@0.0.0.0:8080
         [java] H2 DB started at jdbc:h2:file:runtime/h2/devdb STATUS:TCP server running on tcp://192.168.1.5:9092 (only local connections)
         [java] Creating DB from /private/tmp/my_app/./src/db/model.ddl
         [java] Done
         [java] H2 web console started at http://192.168.1.5:8082/frame.jsp?jsessionid=49c66a20d1ef2583b368dc1a55f4c047
         [java] 
         [java] You can connect to your database using "jdbc:h2:file:runtime/h2/devdb" as your url, and a blank username/password.
         [java] 
         [java] Your Ronin App is listening at http://localhost:8080
         [java] 

(The first time you run `vark server`, it will download some third-party dependencies, which may take a few minutes.)

You now have a Ronin application running at `http://localhost:8080`, hosted on
a Jetty webserver/H2 database combination.

## Model/View/Controller

Ronin follows the model/view/controller architectural paradigm. An MVC
application is broadly divided into three parts:

  * The **model** is the data which the application displays and manipulates.
  * The **view** specifies how the data (and other aspects of the user interface) is displayed.
  * The **controller** queries and manipulates the model, and routes user requests to the correct view.

Ronin is model-agnostic; you may use anything you like, whether it be Tosa,
another ORM system like Hibernate, or even direct SQL calls to a database.

## The Controller

The controllers of a Ronin app are Gosu classes in the "controller" package.
Let's create one now. Create a directory under your project directory called
"controller". In the controller directory, create a file named "Main.gs" with
the following contents:

{% highlight js %}
    package controller

    uses ronin.*

    class Main extends RoninController {
      function hello() {
      }
    }
{% endhighlight %}

This controller has a single function called "hello". When Ronin receives a
request for the URL "`http://localhost:8080/Main/hello`", it calls this
function.

Often, a controller function will require additional parameters - for example,
the controller function for displaying a blog post requires some identifier
with which to retrieve the desired post. This is easily accomplished by adding
arguments to your function's signature, just as with any other Gosu function:

{% highlight js %}
    function hello(name : String) {
{% endhighlight %}

A function with this signature will expect a URL that looks like
"`http://localhost:8080/Main/hello?name=Bob`". This URL would call the "hello"
function, passing in "Bob" as the "name" argument.

See [Controller Arguments](Controller-Arguments.html) for more on how requests are routed to
controller functions.

## The View

The views in a Ronin app are Gosu templates in the "view" package. Typically,
a template will look like an HTML file with snippets of Gosu code scattered
throughout - though there's no reason it has to be HTML; Gosu templates can
produce XML, JSON, or even just plain text.

Create a directory under your project directory called "view", and a file in
that directory called "Hello.gst" with the following contents:

{% highlight html %}
    <%@ extends ronin.RoninTemplate %>
    <%@ params(name : String) %>
    <html>
    <body>
    Hello ${name}!
    </body>
    </html>
{% endhighlight %}

Let's look at each of the components of this template. The first line declares
the "superclass" of this template, which provides easy access to some
convenient methods. See [Views](Views.html) for more information. The second line
declares the parameters required by the template - in this case, a single
String called "name". Following these lines is the text output by the
template. On the fifth line, a Gosu expression is included by enclosing it
with "${}". When the template is rendered, the "name" parameter will be
inserted after "Hello".

Gosu control flow statements can also be included by enclosing them with "<%
%>". For more information, consult the Gosu documentation.

## Tying it Together

Now that you have a controller and a view, the final step is to tell the
controller to render the view in response to a user request. Modify the
"hello" function as follows:

{% highlight js %}
    function hello(name : String) {
      view.Hello.render(writer, name)
    }
{% endhighlight %}

As you can see, rendering the view is simply a matter of calling the
template's render method. The first argument is "writer", which is a property
inherited from `RoninController` containing the output stream for the current
request. Following the first argument are the arguments declared in the
template file - in this case, a single String.

Start the Ronin server following the instructions above (or restart it if
you've already started it). Point a web browser at
"`http://localhost:8080/Main/hello?name=Bob`". You should see

    Hello Bob!

Congratulations! You've completed your first Ronin application.

## Application Layout

Your ronin application is laid out like so:

      /pom.xml - A Maven-style POM for managing dependencies (Maven is not necessary)
      /build.vark - The Aardvark file for your project
      /src - Where all source code goes
          /controller - Where your controllers go
          /config/RoninConfig.gs - Allows you to programmatically configure your Ronin app on startup
          /view - Where your view templates go
          /db - .ddl file(s) containing schema information for your database(s)
      /test - Contains your test source
      /html - The root of the Ronin applications war file
        /WEB-INF/web.xml - A thin web.xml file that will get your Ronin application bootstrapped in a servlet container
        /public - A place you can put static resources, such as images, HTML files or Javascript files.

Now let's look at Ronin in more detail, beginning with [configuring your Ronin server](Server-Configuration.html).