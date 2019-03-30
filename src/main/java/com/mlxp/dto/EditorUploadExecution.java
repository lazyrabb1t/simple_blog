package com.mlxp.dto;

/**
 * @author mlxp
 *  富文本中对于返回值有自己的要求,我们使用是simditor所以按照simditor的要求进行返回
 */
public class EditorUploadExecution {

    //是否上传成功
    private boolean success;

    // error message
    private String msg;

    // real file path
    private String file_path;

    public EditorUploadExecution() {
    }
    //上传失败构造器
    public EditorUploadExecution(boolean success, String msg) {
        super();
        this.success = success;
        this.msg = msg;
    }
    //上传成功构造器
    public EditorUploadExecution(String file_path,boolean success) {
        super();
        this.success = success;
        this.file_path = file_path;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getFile_path() {
        return file_path;
    }

    public void setFile_path(String file_path) {
        this.file_path = file_path;
    }

}
