DROP DATABASE IF EXISTS sapodb;
CREATE DATABASE sapodb;
use sapodb;

drop table if exists tblTile;
drop table if exists tblBoard;

create table tblBoard(
   ID int auto_increment primary key,
   max_row int not null default 10,
   max_col int not null default 10
);


create table tblTile(
	ID int auto_increment primary key,
    `ROW` int not null,
    COL int not null,
    BoardID int not null,
    TileType int not null default 0, 
    foreign key (BoardID) references tblBoard(ID)
);

drop function if exists get_tile_type;
delimiter $$
create function get_tile_type()  returns int
deterministic
begin
  IF ROUND(RAND() * 20) = 9 THEN
    return 1;
  ELSEIF ROUND(RAND() * 10) = 9 THEN
     return 2 ;
  ELSE 
     return 0;
  END IF;
end$$

delimiter ; 

drop procedure if exists make_a_board;
delimiter $$
create procedure make_a_board(pMaxRow INT, pMaxCol INT)
begin
	declare new_board_id INT;
    declare current_row INT default 0;
    declare current_col INT default 0;
    declare tile_type INT default 0;
    
	insert into tblBoard(max_row,max_col)
    value (pMaxRow,pMaxCol);
    
    set new_board_id = LAST_INSERT_ID();
    
    while current_row < pMaxRow do
		while current_col < pMaxCol do
           set tile_type = get_tile_type();
           
            if tile_type <> 0 then 
			  insert into tblTile(BoardID, `ROW`, COL, TileType)
              value (new_board_id, current_row, current_col,tile_type);
			end if;
			set current_col = current_col + 1;
        end while;
        
		set current_col = 0;
        set current_row = current_row + 1;
        
    end while;
    
    select 'Added a board.' as message;
end$$

delimiter ;

call make_a_board(10,10);
select * from tblBoard;
select count(*) from tblTile;

select * from tblTile;



