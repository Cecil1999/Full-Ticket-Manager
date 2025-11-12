class CreateJidSequence < ActiveRecord::Migration[8.1]
  def up
    execute <<~HD
      CREATE SEQUENCE jwt_id_sequence
      start 1
      HD
 end
end
