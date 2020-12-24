package pack.rent.model;

import org.springframework.web.multipart.MultipartFile;

public class UploadFile { //fileDto
	private MultipartFile file;

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
}