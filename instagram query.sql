/*We want to reward our users who have been arround the longest(top 5)*/
use ig_clone;
select * 
from users 
order by created_at 
limit 0,5;

/*what day of the week do most users register on?*/
use ig_clone;
select dayname(created_at) as day,count(dayname(created_at)) as total 
from users 
group by dayname(created_at) 
order by total desc;

/* We want to target our inactive user with an email campaign.(find the users who have never posted a photo)*/
use ig_clone;
select username,image_url 
from users 
left join photos 
on users.id=photos.user_id 
where image_url is null;

/* Find the most popular photos of all time and the user.(the most likes on single photo)*/
use ig_clone;
Select username,photos.id,photos.image_url,count(*) as total
from photos
join likes
on likes.photo_id=photos.id
join users
on users.id=photos.user_id
group by photos.id
order by total desc
limit 0,1;

/* Our investor want to know how many times does the average user post */
use ig_clone;
-- total number of photos/total number of users
select (select count(*) from photos)/(select count(*) from users) as average;

/* Brand wants to know which hastags to use in a post.(top 5 most commonly used hastags*/
use ig_clone;
select tag_name,count(tag_name) as total 
from tags 
join photo_tags 
on photo_tags.tag_id=tags.id 
group by tag_name 
order by total desc 
limit 0,5;

/* Find bots on our site.(find user who have liked every single photo on the site) */
use ig_clone;
select username,user_id,count(*) as num_likes 
from users 
join likes 
on likes.user_id=users.id 
group by user_id 
having num_likes = (select count(*) from photos);
