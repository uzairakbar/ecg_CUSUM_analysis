# ecg_signal_analysis_for_mi_detection

| **TITLE:**  | ECG Signal Analysis for MI Detection |
| ------------- | ----------- |
| **AUTHORS:**  | Uzair Akbar, Asfandyar Hassan Shah, Mahnoor Haneef, Ryshum Ali, Saad Qureshi |
| **INSTITUTION:**  | National University of Sciences & Technology (NUST), Sector H-12, Islamabad Pakistan. |
| **DATED:**  | May 29, 2015 |
| **VERSION:**  | 0.24 |
| **LICENSE:**  | CC0 1.0 Universal |
| **DOCUMENTATION:**  | [Project Report](http://www.slideshare.net/UzairAkbar/ecg-signal-analysis-for-myocardial-infarction-detection), [Project Presentation](http://www.slideshare.net/UzairAkbar/ecg-signal-analysis-for-myocardial-infarction-detection-74177496) |

## DESCRIPTION:

*Myocardial Infarction* is one of the fatal heart diseases. It is essential that a patient is monitored for the early detection of MI. Owing to the newer technology such as wearable sensors which are capable of transmitting wirelessly, this can be done easily. However, there is a need for *real-time* applications that are able to accurately detect MI *non-invasively*.

This project studies a prospective method by which we can detect MI. Our approach analyses the *ECG* (electrocardiogram) of a patient in real-time and extracts the **ST elevation** from each cycle. The ST elevation plays an important part in MI detection. We then use the sequential change point detection algorithm; **CUmulative SUM** (CUSUM), to detect any deviation in the ST elevation spectrum and to raise an alarm if we find any.

The project uses the EDB medical database from the *PhysioNet*. This database consists of 90 annotated ECG recordings from 79 subjects. These subjects have various heart anomalies (*vessel disease*, *hypertension*, *coronary artery disease*, *ventricular dyskinesia*, and *myocardial infarction*). Each data trace is **two hours** in duration and contains two signals (2-lead ECG), each sampled at **250 samples per second** with **12-bit resolution** over a nominal 20 millivolt input range. The sample values were rescaled after digitization with reference to calibration signals in the original analog recordings, in order to obtain a uniform scale of 200 ADC units per millivolt for all signals. The database is available at:

[Physionet ECG Database](http://www.physionet.org/physiobank/database/edb/)

Patient `e0105.dat` was particalarly interesting as he has Inferior myocardial infarction and our algorithm showed positive results for the ECG.
