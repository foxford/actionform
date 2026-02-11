class CreateTables < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.integer :gender
      t.timestamps null: false
    end

    create_table :emails do |t|
      t.string :address
      t.references :user, index: true
      t.timestamps null: false
    end

    create_table :profiles do |t|
      t.string :twitter_name
      t.string :github_name
      t.references :user, index: true
      t.timestamps null: false
    end

    create_table :songs do |t|
      t.string :title
      t.string :length
      t.timestamps null: false
    end

    create_table :artists do |t|
      t.string :name
      t.references :song, index: true
      t.timestamps null: false
    end

    create_table :producers do |t|
      t.string :name
      t.string :studio
      t.references :artist, index: true
      t.timestamps null: false
    end

    create_table :conferences do |t|
      t.string :name
      t.string :city
      t.timestamps null: false
    end

    create_table :speakers do |t|
      t.string :name
      t.string :occupation
      t.references :conference, index: true
      t.timestamps null: false
    end

    create_table :presentations do |t|
      t.string :topic
      t.string :duration
      t.references :speaker, index: true
      t.timestamps null: false
    end

    create_table :surveys do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :questions do |t|
      t.text :content
      t.references :survey, index: true
      t.timestamps null: false
    end

    create_table :answers do |t|
      t.text :content
      t.references :question, index: true
      t.timestamps null: false
    end

    create_table :projects do |t|
      t.string :name
      t.string :description
      t.integer :owner_id
      t.timestamps null: false
    end

    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.boolean :done
      t.references :project, index: true
      t.timestamps null: false
    end

    create_table :sub_tasks do |t|
      t.string :name
      t.string :description
      t.boolean :done
      t.references :task, index: true
      t.timestamps null: false
    end

    create_table :people do |t|
      t.string :name
      t.string :description
      t.string :role
      t.references :project, index: true
      t.timestamps null: false
    end

    create_table :tags do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :project_tags do |t|
      t.references :project, index: true
      t.references :tag, index: true
      t.timestamps null: false
    end

    create_table :assignments do |t|
      t.string :name
      t.timestamps null: false
    end

    add_reference :tasks, :assignment, index: true
  end
end
