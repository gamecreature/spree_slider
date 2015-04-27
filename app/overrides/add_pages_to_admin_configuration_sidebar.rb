Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'slides_admin_configurations_menu',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/slides_sidebar_menu'
)
