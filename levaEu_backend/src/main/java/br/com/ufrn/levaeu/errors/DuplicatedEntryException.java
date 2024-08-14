package br.com.ufrn.levaeu.errors;

public class DuplicatedEntryException extends Exception{

    public DuplicatedEntryException(String message) {
        super(message);
    }
}
