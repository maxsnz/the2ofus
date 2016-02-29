# encoding: utf-8

ActiveAdmin.register User do
  actions :all, :except => [:new]
  config.sort_order = "id_desc"
  # config.per_page = 400
  config.batch_actions = true
  # permit_params :name, :email, :phone, :company
 
  # index do

  #   selectable_column
  #   column :created_at
  #   column :name
  #   column :email
  #   column :phone, sortable: false
  #   column :company
  #   actions
  # end
end
