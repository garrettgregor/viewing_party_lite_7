# frozen_string_literal: true

class AddHostToViewingParties < ActiveRecord::Migration[7.0]
  def change
    add_column :viewing_parties, :host_id, :integer
  end
end
