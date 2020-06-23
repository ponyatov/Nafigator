## core module

import logging
let logger = newConsoleLogger(fmtStr = "[$date $time] - $levelname: ")

when isMainModule:
  addHandler(logger)
  logger.log(lvlInfo, "NIM Nafigator")
  logger.log(lvlInfo, "info")
  logger.log(lvlDebug, "debug")
