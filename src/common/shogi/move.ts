import { Color } from "./color";
import { Piece, PieceType, pieceTypeToSFEN } from "./piece";
import { Square } from "./square";

export class Move {
  constructor(
    public from: Square | PieceType,
    public to: Square,
    public promote: boolean,
    public color: Color,
    public pieceType: PieceType,
    public capturedPieceType: PieceType | null
  ) {}

  equals(move: Move | null | undefined): boolean {
    if (!move) {
      return false;
    }
    return (
      ((this.from instanceof Square &&
        move.from instanceof Square &&
        this.from.equals(move.from)) ||
        (!(this.from instanceof Square) &&
          !(move.from instanceof Square) &&
          this.from === move.from)) &&
      this.to.equals(move.to) &&
      this.promote === move.promote &&
      this.color === move.color &&
      this.pieceType === move.pieceType &&
      this.capturedPieceType === move.capturedPieceType
    );
  }

  withPromote(): Move {
    return new Move(
      this.from,
      this.to,
      true,
      this.color,
      this.pieceType,
      this.capturedPieceType
    );
  }

  get usi(): string {
    let ret = "";
    if (this.from instanceof Square) {
      ret += this.from.sfen;
    } else {
      ret += pieceTypeToSFEN(this.from) + "*";
    }
    ret += this.to.sfen;
    if (this.promote) {
      ret += "+";
    }
    return ret;
  }
}

export function parseUSIMove(usiMove: string): {
  from: Square | PieceType;
  to: Square;
  promote: boolean;
} | null {
  let from: PieceType | Square;
  if (usiMove[1] === "*") {
    const piece = Piece.newBySFEN(usiMove[0]);
    if (!piece) {
      return null;
    }
    from = piece.type;
  } else {
    const square = Square.parseSFENSquare(usiMove);
    if (!square) {
      return null;
    }
    from = square;
  }
  const to = Square.parseSFENSquare(usiMove.substring(2));
  if (!to) {
    return null;
  }
  const promote = usiMove.length >= 5 && usiMove[4] === "+";
  return { from, to, promote };
}
