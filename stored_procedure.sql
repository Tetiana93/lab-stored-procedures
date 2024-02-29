DELIMITER //
create procedure contact_info_custom()
begin
select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  end //
  DELIMITER ;
  call contact_info_custom();
  DELIMITER //
  create procedure contact_info_custom_category(in param varchar(50))
  begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = param
  group by first_name, last_name, email;
  end //
  DELIMITER ;
  call contact_info_custom_category("children");
  drop procedure if exists count_category_proc;
  DELIMITER //
  create procedure count_category_proc(in numb int)
  begin
  select name, count(film_id) as count_category
  from category
  join film_category using(category_id)
  join film using(film_id)
  group by name
  having count_category> numb;
  end //
  DELIMITER ;
  call count_category_proc(70);
  SHOW CREATE PROCEDURE count_category_proc;