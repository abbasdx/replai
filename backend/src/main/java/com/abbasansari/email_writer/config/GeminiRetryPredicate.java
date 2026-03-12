package com.abbasansari.email_writer.config;

import com.abbasansari.email_writer.exception.ExternalServiceException;

import java.util.function.Predicate;

public class GeminiRetryPredicate implements Predicate<Throwable> {

    @Override
    public boolean test(Throwable throwable) {
        if (throwable instanceof ExternalServiceException externalServiceException) {
            return externalServiceException.isTransientFailure();
        }

        return false;
    }
}
