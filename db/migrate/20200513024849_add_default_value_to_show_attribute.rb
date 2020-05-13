class AddDefaultValueToShowAttribute < ActiveRecord::Migration[5.2]
  def change
      def up
        change_column :users, :is_active, :boolean, default: true
      end
  end
end
