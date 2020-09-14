class CreateVoteOnIssues < ActiveRecord::Migration[4.2]
  def self.up
    create_table :vote_on_issues do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.references :issue, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :vote_val
    end
    # add_index :vote_on_issues, [:issue_id, :user_id], unique: true
  end
  
  def self.down
    drop_table :vote_on_issues
  end
end
