class CreateVoteOnIssues < ActiveRecord::Migration[5.2]
  def self.up
    create_table :vote_on_issues do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :issue_id, index: true, foreign_key: true
      t.integer :user_id, index: true, foreign_key: true
      t.integer :vote_val
    end
    # add_index :vote_on_issues, [:issue_id, :user_id], unique: true
  end
  
  def self.down
    drop_table :vote_on_issues
  end
end
