package com.javalec.ex.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javalec.ex.dao.BDao;
import com.javalec.ex.dto.BDto;

public class BListCommand implements BCommand {

	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		BDao dao = new BDao(); //Db연결 객체 만듦
		ArrayList<BDto> dtos = dao.list();
		request.setAttribute("list", dtos);

	}

}
