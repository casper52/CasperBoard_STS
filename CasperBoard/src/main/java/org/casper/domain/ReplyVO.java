package org.casper.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private int rno, bno, parent, depth;
	private String reply, replyer;
	private Date replyDate, updateDate;
}
