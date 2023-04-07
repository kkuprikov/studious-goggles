ROM::SQL.migration do
  change do
    create_table :shifts do
      primary_key :id
      foreign_key :worker_id, :workers
      column :day, Date, null: false
      column :interval, Integer, null: false
    end
  end
end
  