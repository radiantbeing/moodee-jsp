package dto;

import java.util.Date;

public class Post {
	private Date date; // Unique
	private String videoId;
	private String song;
	private String artist;
	private String article;
	
	public Post() {
		
	}

	public Post(Date date, String videoId, String song, String artist, String article) {
		super();
		this.date = date;
		this.videoId = videoId;
		this.song = song;
		this.artist = artist;
		this.article = article;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getSong() {
		return song;
	}

	public void setSong(String song) {
		this.song = song;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}

	public String getArticle() {
		return article;
	}

	public void setArticle(String article) {
		this.article = article;
	}

	public String getVideoId() {
		return videoId;
	}

	public void setVideoId(String videoId) {
		this.videoId = videoId;
	}

	
}
