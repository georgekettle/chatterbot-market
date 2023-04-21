class AddReadAtToFeedback < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :marked_read_at, :datetime, default: nil
  end
end
