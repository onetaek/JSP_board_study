package com.javalec.ex.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javalec.ex.dao.BDao;
import com.javalec.ex.dto.BDto;
import com.mysql.cj.x.protobuf.MysqlxDatatypes.Scalar.String;

public class BContentCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String bId = request.getParameter("bId"); //get방식으로 url에 실어서 보냈음
		BDao dao = new BDao();//DB연결객체생성
		BDto dto = dao.contentView(bId);
		
		request.setAttribute("content_view", dto);

	}
	
}
