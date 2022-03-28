LIGHT_SPEED_M_PER_S = 299792458.0;

struct Fmcw
    chirp_bandwidth::Any
    chirp_period::Any
    chirp_rate::Any
    sampling_period::Any
    carrier_freq::Any
end

function chirp(fmcw::Fmcw, phase_offset, n, t)
    alpha = fmcw.bandwidth / fmcw.period
    return A * cos(
        2 *
        pi *
        (
            fmcw.carrier_freq * (n * fmcw.period + t) +
            (alpha / 2) * (n * fmcw.period + t)^2 +
            phase_offset
        ),
    )
end

function if_response_approx(fmcw::Fmcw, range, velocity, amplitude, n, t)
    beat_freq = 2 * fmcw.chirp_rate * range / LIGHT_SPEED_M_PER_S
    doppler_freq = 2 * velocity * fmcw.carrier_freq / LIGHT_SPEED_M_PER_S
    phase = 2 * fmcw.carrier_freq * range / LIGHT_SPEED_M_PER_S
    return amplitude * exp(
        im * (2 * pi * ((beat_freq * t) + (doppler_freq * n * fmcw.chirp_period) + phase)),
    )
end

function if_response()
    beat_freq = 2 * fmcw.chirp_rate * range / LIGHT_SPEED_M_PER_S
    doppler_freq = 2 * velocity * fmcw.carrier_freq / LIGHT_SPEED_M_PER_S
    phase = 2 * fmcw.carrier_freq * range / LIGHT_SPEED_M_PER_S

    # TODO(omar): Implement the rest of this with all the terms
end
