% Parameters:
% 1. Using averages for DE+Blank
% 2. Add variance on ISI within the bursts (This will be based on stereotype data that you analyzed)
% 3. Add variance on frequency of bursts
% 4. Every other parameter would be the same
% 5. Add poisson noise as inter bursts spikes

function [ spike_train ] = Natural_BurstFreq_ISIInBurst(total_time, out_file)
    spike_train = [];
    ISI_Means = [ .015354; .027544; .023193; .021264; .020545; .022007; .020066; .019243; .020584; .020584];
    while sum(spike_train) < total_time
        burst = exprnd(ISI_Means); % Each unit in burst is pulled from an exponential random distribution
        IBI = exprnd(3.329188);
        noise = [];
        while sum(noise) < IBI
            noise = [ noise; exprnd(.528013) ];
        end
        spike_train = [ spike_train; burst; noise ];
    end
    xlswrite(out_file, spike_train);
end