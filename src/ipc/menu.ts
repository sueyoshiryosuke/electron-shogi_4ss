export enum MenuEvent {
  NEW_RECORD = "resetRecord",
  OPEN_RECORD = "openRecord",
  SAVE_RECORD = "saveRecord",
  SAVE_RECORD_AS = "saveRecordAs",
  COPY_RECORD = "copyRecord",
  COPY_RECORD_CSA = "copyRecordCsa",
  COPY_RECORD_USI_BEFORE = "copyRecordUsiBefore",
  COPY_RECORD_USI_ALL = "copyRecordUsiAll",
  COPY_BOARD_SFEN = "copyRecordSfen",
  PASTE_RECORD = "pasteRecord",
  INSERT_INTERRUPT = "insertInterrupt",
  INSERT_RESIGN = "insertResign",
  INSERT_DRAW = "insertDraw",
  INSERT_REPETITION_DRAW = "insertRepetitionDraw",
  INSERT_MATE = "insertMate",
  INSERT_TIMEOUT = "insertTimeout",
  INSERT_FOUL_WIN = "insertFoulWin",
  INSERT_FOUL_LOSE = "insertFoulLose",
  INSERT_ENTERING_OF_KING = "insertEnteringOfKing",
  INSERT_WIN_BY_DEFAULT = "insertWinByDefault",
  INSERT_LOSS_BY_DEFAULT = "insertLossByDefault",
  REMOVE_RECORD_AFTER = "remvoeRecordAfter",
  START_POSITION_EDITING = "startPositionEditing",
  END_POSITION_EDITING = "endPositionEditing",
  CHANGE_TURN = "changeTurn",
  INIT_POSITION_STANDARD = "initPositionStandard",
  INIT_POSITION_HANDICAP_LANCE = "initPositionHandicapLance",
  INIT_POSITION_HANDICAP_RIGHT_LANCE = "initPositionHandicapRightLance",
  INIT_POSITION_HANDICAP_BISHOP = "initPositionHandicapBishop",
  INIT_POSITION_HANDICAP_ROOK = "initPositionHandicapRook",
  INIT_POSITION_HANDICAP_ROOK_LANCE = "initPositionHandicapRookLance",
  INIT_POSITION_HANDICAP_2PIECES = "initPositionHandicap2Pieces",
  INIT_POSITION_HANDICAP_4PIECES = "initPositionHandicap4Pieces",
  INIT_POSITION_HANDICAP_6PIECES = "initPositionHandicap6Pieces",
  INIT_POSITION_HANDICAP_8PIECES = "initPositionHandicap8Pieces",
  INIT_POSITION_TSUME_SHOGI = "initPositionTsumeShogi",
  INIT_POSITION_TSUME_SHOGI_2KINGS = "initPositionTsumeShogi2Kings",
  START_RESEARCH = "startResearch",
  STOP_RESEARCH = "stopResearch",
  START_ANALYSIS = "startAnalysis",
  STOP_ANALYSIS = "stopAnalysis",
  START_GAME = "startGame",
  START_CSA_GAME = "startCSAGame",
  STOP_GAME = "stopGame",
  RESIGN = "resign",
  WIN = "win",
  LOGOUT = "logout",
  FLIP_BOARD = "flipBoard",
  APP_SETTING_DIALOG = "appSetting",
  USI_ENGINE_SETTING_DIALOG = "usiEngineSetting",
}
