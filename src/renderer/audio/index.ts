let lastLongBeep: OscillatorNode | undefined;

function beep(options?: {
  type?: OscillatorType;
  frequency?: number;
  time?: number;
  volume?: number;
}): void {
  if (lastLongBeep) {
    return;
  }
  const type = options?.type || "sine";
  const frequency = options?.frequency || 440;
  const volume = options?.volume || 2;
  const context = new AudioContext();
  const oscillator = context.createOscillator();
  const gain = context.createGain();
  oscillator.connect(gain);
  gain.connect(context.destination);
  oscillator.type = type;
  oscillator.frequency.value = frequency;
  gain.gain.value = volume * 0.005;
  oscillator.onended = () => {
    gain.disconnect(context.destination);
    oscillator.disconnect(gain);
  };
  oscillator.start(context.currentTime);
  if (options?.time) {
    oscillator.stop(context.currentTime + options.time);
  }
  if (!options?.time) {
    lastLongBeep = oscillator;
  }
}

export function beepShort(options: {
  frequency?: number;
  volume?: number;
}): void {
  beep({
    type: "sine",
    frequency: options.frequency,
    time: 0.1,
    volume: options.volume,
  });
}

export function beepUnlimited(options: {
  frequency?: number;
  volume?: number;
}): void {
  beep({
    type: "sine",
    frequency: options.frequency,
    volume: options.volume,
  });
}

export function stopBeep(): void {
  if (lastLongBeep) {
    lastLongBeep.stop();
    lastLongBeep = undefined;
  }
}

let lastPieceBeatTime: number;

export function playPieceBeat(volume: number): void {
  const time = Date.now();
  if (lastPieceBeatTime && time < lastPieceBeatTime + 200) {
    return;
  }
  const audio = new Audio("sound/piece.mp3");
  audio.volume = volume * 0.01;
  audio.play();
  lastPieceBeatTime = time;
}
