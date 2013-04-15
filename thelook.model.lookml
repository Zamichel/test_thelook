- scoping: true       # for backward compatibility

- connection: thelook
- include: thelook.includes

- base_view: inventory_items
  view: inventory_items
  label: Inventory Items
  joins:
    - join: products
      sql_on: inventory_items.product_id=products.id

- base_view: orders
  view: orders
  label: Orders
  joins:
    - join: users
      sql_on: orders.user_id=users.id

- base_view: order_items
  view: order_items
  label: Order Items
  joins:
    - join: inventory_items
      sql_on: order_items.inventory_item_id=inventory_items.id
    - join: orders
      sql_on: order_items.order_id=orders.id
    - join: products
      sql_on: inventory_items.product_id=products.id
      required_joins: [inventory_items]
    - join: users
      sql_on: orders.user_id=users.id
      required_joins: [orders]

- base_view: products
  view: products
  label: Products

- base_view: users
  view: users
  label: Users

# - base_view: user_data
#   view: user_data
#   label: User Data
#   joins:
#     - join: users
#       sql_on: user_data.user_id=users.id

# - base_view: events
#   view: events
#   label: Events
#   joins:
#     - join: users
#       sql_on: events.user_id=users.id

# - base_view: schema_migrations
#   view: schema_migrations
#   label: Schema Migrations
