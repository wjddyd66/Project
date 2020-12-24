package pack.rent.model;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component("fileValidater")
public class FileValidater implements Validator {
	public boolean supports(Class<?> clazz) {
		return false;
	}

	public void validate(Object uploadFile, Errors errors) {
		UploadFile file = (UploadFile)uploadFile;
		if(file.getFile().getSize()==0) {
			errors.rejectValue("file", "","업로드 파일을 선택하시오");
		}
	}
}
