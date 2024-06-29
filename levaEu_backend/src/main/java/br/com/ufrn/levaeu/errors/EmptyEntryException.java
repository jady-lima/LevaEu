package br.com.ufrn.levaeu.errors;

public class EmptyEntryException extends Exception{
	public EmptyEntryException(String message) {
		super(message);
	}
}