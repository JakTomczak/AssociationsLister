# AssociationsLister
When using Elixir, Ecto, Postgres and CSV, you can use this snippet to encode your database associations in a .csv.

Let's say you have Elixir project 
* with PostgreSQL database,
* using Ecto,
* with CSV as dependency (in your `mix.exs` inside your `deps` you have `{:csv, "~> 2.3.1"}`).

Then you can use this snippet to make a .csv file listing all database tables associations your project (repo) contains.

The created .csv have three columns:
* From - name of the table which belongs to the other table,
* To - name of the table association ends in,
* Association_name - name of the association. You may want to check out the 27th line of the snippet to customize output in this column.
