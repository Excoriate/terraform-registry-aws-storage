package logger

import (
  "github.com/Excoriate/terraform-registry-aws-storage/internal/common"
  "github.com/hashicorp/go-hclog"
  "os"
)

var (
  logLevel  = os.Getenv("LOG_LEVEL")
  isEnabled = os.Getenv("LOG_ENABLED")
  format    = os.Getenv("LOG_FORMAT")
)

type SecretFillerLog struct {
}

type Logger interface {
  LogInfo(action, message string, args ...interface{})
  LogWarn(action, message string, args ...interface{})
  LogError(action, message string, args ...interface{})
  LogDebug(action, message string, args ...interface{})
  InitLogger() hclog.Logger
}

func IsEnabled() bool {
  if isEnabled == "" {
    // Force to enable it by default
    isEnabled = "true"
  }

  return isEnabled == "true"
}

func getLogger() hclog.Logger {
  appLogger := hclog.New(&hclog.LoggerOptions{
    Name:  "secret-manager-filler",
    Level: hclog.LevelFromString(common.NormaliseStringUpper(logLevel)),
  })

  return appLogger
}

func (l *SecretFillerLog) InitLogger() hclog.Logger {
  if !IsEnabled() {
    return nil
  }

  return getLogger()
}

func (l *SecretFillerLog) LogInfo(action, message string, args ...interface{}) {
  if !IsEnabled() {
    return
  }

  logger := getLogger()
  if action != "" {
    logger = logger.With("action")
  }

  logger.Info(message, args...)
}

func (l *SecretFillerLog) LogWarn(action, message string, args ...interface{}) {
  if !IsEnabled() {
    return
  }

  logger := getLogger()
  if action != "" {
    logger = logger.With("action")
  }

  logger.Warn(message, args...)
}

func (l *SecretFillerLog) LogError(action, message string, args ...interface{}) {
  if !IsEnabled() {
    return
  }

  logger := getLogger()
  if action != "" {
    logger = logger.With("action")
  }

  logger.Error(message, args...)
}

func (l *SecretFillerLog) LogDebug(action, message string, args ...interface{}) {
  if !IsEnabled() {
    return
  }

  logger := getLogger()
  if action != "" {
    logger = logger.With("action")
  }

  logger.Debug(message, args...)
}
