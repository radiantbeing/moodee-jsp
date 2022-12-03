package dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import dto.Post;

public class PostRepository {
	private ArrayList<Post> listOfPosts = new ArrayList<Post>();
	private static PostRepository instance = new PostRepository();

	public static PostRepository getInstance() {
		return instance;
	}
	
	Date getDate(int year, int month, int day, int hour, int minute) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, day, hour, minute);
		return cal.getTime();
	}
	
	public PostRepository() {
//		Post horizon = new Post(getDate(2022, 11, 23, 2, 33), "BBdC1rl5sKY", "사건의 지평선", "윤하", "왜 이 곡을 이제야 알았지?");
//		Post solar = new Post(getDate(2022, 11, 23, 2, 36), "lCOiahfnNIw", "태양계", "성시경", "새벽의 오묘한 기분엔 역시 태양계");
//		Post autumn = new Post(getDate(2022, 11, 23, 2, 37), "H1NHCJLxHrs", "만추", "헤이즈", "늦가을이면 항상 생각난다.");
//		
//		listOfPosts.add(horizon);
//		listOfPosts.add(solar);
//		listOfPosts.add(autumn);
	}

	public ArrayList<Post> getAllPosts() {
		return listOfPosts;
	}
	
	public void addPost(String videoId, String songTitle, String artist, String article) {
		Date date = new Date();
		listOfPosts.add(new Post(date, videoId, songTitle, artist, article));
	}
}
