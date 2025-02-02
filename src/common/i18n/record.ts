import { RecordMetadataKey } from "@/common/shogi";
import { t } from "./translate";

export function getRecordMetadataName(key: RecordMetadataKey): string {
  switch (key) {
    case RecordMetadataKey.BLACK_NAME:
      return t.sente;
    case RecordMetadataKey.WHITE_NAME:
      return t.gote;
    case RecordMetadataKey.START_DATETIME:
      return t.startDateTime;
    case RecordMetadataKey.END_DATETIME:
      return t.endDateTime;
    case RecordMetadataKey.DATE:
      return t.gameDate;
    case RecordMetadataKey.TOURNAMENT:
      return t.tournament;
    case RecordMetadataKey.STRATEGY:
      return t.strategy;
    case RecordMetadataKey.TITLE:
      return t.gameTitle;
    case RecordMetadataKey.TIME_LIMIT:
      return t.timeLimit;
    case RecordMetadataKey.TIME_SPENT:
      return t.elapsedTime;
    case RecordMetadataKey.PLACE:
      return t.place;
    case RecordMetadataKey.POSTED_ON:
      return t.postedOn;
    case RecordMetadataKey.NOTE:
      return t.note;
    case RecordMetadataKey.BLACK_SHORT_NAME:
      return t.senteShortName;
    case RecordMetadataKey.WHITE_SHORT_NAME:
      return t.goteShortName;
    case RecordMetadataKey.OPUS_NO:
      return t.opusNo;
    case RecordMetadataKey.OPUS_NAME:
      return t.opusName;
    case RecordMetadataKey.AUTHOR:
      return t.author;
    case RecordMetadataKey.PUBLISHED_BY:
      return t.publishedBy;
    case RecordMetadataKey.PUBLISHED_AT:
      return t.publishedOn;
    case RecordMetadataKey.SOURCE:
      return t.source;
    case RecordMetadataKey.LENGTH:
      return t.numberOfMoves;
    case RecordMetadataKey.INTEGRITY:
      return t.integrity;
    case RecordMetadataKey.CATEGORY:
      return t.recordCategory;
    case RecordMetadataKey.AWARD:
      return t.award;
  }
}
