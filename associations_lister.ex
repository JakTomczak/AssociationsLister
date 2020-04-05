defmodule AssociationsLister do
  @spec run(Ecto.Repo.t()) :: :ok
  def run(repo) do
    file_name = "associations.csv"
    file = File.open!(file_name, [:write, :utf8])

    [~w(From To Association_name)] # columns names
    |> CSV.encode()
    |> Enum.each(&IO.write(file, &1))  

    query = """
      SELECT
        (tc.table_name, ccu.table_name, tc.constraint_name)
      FROM
          information_schema.table_constraints AS tc
      JOIN information_schema.key_column_usage AS kcu ON
          tc.constraint_name = kcu.constraint_name
      JOIN information_schema.constraint_column_usage AS ccu ON
          ccu.constraint_name = tc.constraint_name
      WHERE constraint_type = 'FOREIGN KEY'
      """

    {:ok, results} = Ecto.Adapters.SQL.query(repo, query, [])

    results.rows
    |> Enum.map(fn [{from, to, name}] ->
      name = String.slice(name, (String.length(from)+1)..-9)
      [from, to, name]
    end)
    |> CSV.encode()
    |> Enum.each(&IO.write(file, &1))  
  end
end
