- view: order_items
  fields:
  
# DIMENSIONS #

  - dimension: id
    type: int
    primary_key: true
    sql: ${TABLE}.id

  - dimension: inventory_item_id
    type: int
    hidden: true
      
  - dimension: return_date
    type: date
    sql: ${TABLE}.returned_at
    
  - dimension: returned
    type: yesno
    sql: ${return_date}  

  - dimension: order_id
    type: int
    hidden: true

  - dimension: sale_price
    description: The sale price reflects the price thtat the item was sold at.
    type: number
    decimals: 2
    
  - dimension: gross_margin
    type: number
    decimals: 2
    sql: ${sale_price} - ${inventory_items.cost}
    
#   - dimension: item_gross_margin_percentage
#     type: number
#     sql: 100.0 * ${item_gross_margin}/${sale_price}
# 
#   - dimension: item_gross_margin_percentage_tier
#     type: tier
#     sql: ${item_gross_margin_percentage}
#     tiers: [0,10,20,30,40,50,60,70,80,90]

# MEASURES #

  - measure: count
    type: count
    detail: detail
    
#   - measure: total_gross_margin
#     type: sum
#     sql: ${item_gross_margin}
#     decimals: 2
    
  - measure: total_sale_price
    type: sum
    sql: ${sale_price}
    decimals: 2
    html: |
      $<%= rendered_value %>

  - measure: average_sale_price
    type: average
    sql: ${sale_price}
    decimals: 2
    html: |
      $<%= rendered_value %>

#   - measure: gross_margin_percentage
#     type: number
#     sql: 100.0 * ${total_gross_margin}/${total_sale_price}    # postgres does integer division by default, so multiply by 100.0
#     decimals: 2                                               #  to force real numbers.


# SETS #

  sets:
    detail:
      - orders.created_date
      - id
      - orders.id
      - users.name
      - users.history
      - products.item_name
      - products.brand
      - products.category
      - products.department
      - total_sale_price