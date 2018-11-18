function varargout = fourier_mod(varargin)
% FOURIER_MOD MATLAB code for fourier_mod.fig
%      FOURIER_MOD, by itself, creates a new FOURIER_MOD or raises the existing
%      singleton*.
%
%      H = FOURIER_MOD returns the handle to a new FOURIER_MOD or the handle to
%      the existing singleton*.
%
%      FOURIER_MOD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIER_MOD.M with the given input arguments.
%
%      FOURIER_MOD('Property','Value',...) creates a new FOURIER_MOD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fourier_mod_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fourier_mod_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fourier_mod

% Last Modified by GUIDE v2.5 18-Nov-2018 13:48:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fourier_mod_OpeningFcn, ...
                   'gui_OutputFcn',  @fourier_mod_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before fourier_mod is made visible.
function fourier_mod_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fourier_mod (see VARARGIN)

% Choose default command line output for fourier_mod
handles.output = hObject;

% Ensure uipanels are parented by the figure
% panel_handles = findobj(handles.mainwrapper,'type','uipanel');
% set( panel_handles, 'parent', handles.mainwrapper);

% --- Tabs Code ---
% Settings
TabFontSize = 10;
TabNames = {'Punto 1','Punto 2','Punto 3'};
FigWidth = 1.0;

% Figure resize
set(handles.mainwrapper,'Units','normalized')
pos = get(handles.mainwrapper, 'Position');
set(handles.mainwrapper, 'Position', [pos(1) pos(2) FigWidth pos(4)])

% Tabs Execution
handles = TabsFun(handles,TabFontSize,TabNames);

% Load  static images into the axes
modem_asset = imread('modem_step.png');
quad_asset = imread('quad_step.png');
dsb_asset = imread('am_dsb.png');

% Set all static images
axes(handles.dismodem1)
image(modem_asset)
axis off
axis image

axes(handles.dispquad)
image(quad_asset)
axis off
axis image

axes(handles.dispdsb)
image(dsb_asset)
axis off
axis image

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fourier_mod wait for user response (see UIRESUME)
% uiwait(handles.mainwrapper);

%% Funciones
function S = myNumberCheck(ObjH, eventdata)
S = get(ObjH, 'String');
if ~all(ismember(S, '.1234567890'))
    set(ObjH,'string','-');
    warndlg('Debe seleccionar un número');
else
    S = str2double(S);
end

function S = onlyNumberCheck(inpnum)
S = inpnum;
if ~all(ismember(inpnum, '.1234567890'))
    S = '';
else
    S = str2double(S);
end

% --- TabsFun creates axes and text objects for tabs
function handles = TabsFun(handles,TabFontSize,TabNames)
% Set the colors indicating a selected/unselected tab
handles.selectedTabColor=get(handles.tab1Panel,'BackgroundColor');
handles.unselectedTabColor=handles.selectedTabColor-0.1;
% Create Tabs
TabsNumber = length(TabNames);
handles.TabsNumber = TabsNumber;
TabColor = handles.selectedTabColor;
for i = 1:TabsNumber
    n = num2str(i);
    
    % Get text objects position
    set(handles.(['tab',n,'text']),'Units','normalized')
    pos=get(handles.(['tab',n,'text']),'Position');
    % Create axes with callback function
    handles.(['a',n]) = axes('Units','normalized',...
                    'Box','on',...
                    'XTick',[],...
                    'YTick',[],...
                    'Color',TabColor,...
                    'Position',[pos(1) pos(2) pos(3) pos(4)+0.01],...
                    'Tag',n,...
                    'ButtonDownFcn',[mfilename,'(''ClickOnTab'',gcbo,[],guidata(gcbo))']);
                    
    % Create text with callback function
    handles.(['t',n]) = text('String',TabNames{i},...
                    'Units','normalized',...
                    'Position',[pos(3),pos(2)/2+pos(4)],...
                    'HorizontalAlignment','left',...
                    'VerticalAlignment','middle',...
                    'Margin',0.001,...
                    'FontSize',TabFontSize,...
                    'Backgroundcolor',TabColor,...
                    'Tag',n,...
                    'ButtonDownFcn',[mfilename,'(''ClickOnTab'',gcbo,[],guidata(gcbo))']);
    TabColor = handles.unselectedTabColor;
end
            
% Manage panels (place them in the correct position and manage visibilities)
set(handles.tab1Panel,'Units','normalized')
pan1pos=get(handles.tab1Panel,'Position');
set(handles.tab1text,'Visible','off')
for i = 2:TabsNumber
    n = num2str(i);
    set(handles.(['tab',n,'Panel']),'Units','normalized')
    set(handles.(['tab',n,'Panel']),'Position',pan1pos)
    set(handles.(['tab',n,'Panel']),'Visible','off')
    set(handles.(['tab',n,'text']),'Visible','off')
end
% --- Callback function for clicking on tab
function ClickOnTab(hObject,~,handles)
m = str2double(get(hObject,'Tag'));
for i = 1:handles.TabsNumber;
    n = num2str(i);
    if i == m
        set(handles.(['a',n]),'Color',handles.selectedTabColor)
        set(handles.(['t',n]),'BackgroundColor',handles.selectedTabColor)
        set(handles.(['tab',n,'Panel']),'Visible','on')
    else
        set(handles.(['a',n]),'Color',handles.unselectedTabColor)
        set(handles.(['t',n]),'BackgroundColor',handles.unselectedTabColor)
        set(handles.(['tab',n,'Panel']),'Visible','off')
    end
end

% --- Outputs from this function are returned to the command line.
function varargout = fourier_mod_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set max size of the windows
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in selectmenumod1.
function selectmenumod1_Callback(hObject, eventdata, handles)
% hObject    handle to selectmenumod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectmenumod1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectmenumod1


% --- Executes during object creation, after setting all properties.
function selectmenumod1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectmenumod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in selectmenucar1.
function selectmenucar1_Callback(hObject, eventdata, handles)
% hObject    handle to selectmenucar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectmenucar1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectmenucar1


% --- Executes during object creation, after setting all properties.
function selectmenucar1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectmenucar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ampmod1_Callback(hObject, eventdata, handles)
% hObject    handle to ampmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ampmod1 as text
%        str2double(get(hObject,'String')) returns contents of ampmod1 as a double


% --- Executes during object creation, after setting all properties.
function ampmod1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ampmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ampcar1_Callback(hObject, eventdata, handles)
% hObject    handle to ampcar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ampcar1 as text
%        str2double(get(hObject,'String')) returns contents of ampcar1 as a double


% --- Executes during object creation, after setting all properties.
function ampcar1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ampcar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frecmod1_Callback(hObject, eventdata, handles)
% hObject    handle to frecmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frecmod1 as text
%        str2double(get(hObject,'String')) returns contents of frecmod1 as a double


% --- Executes during object creation, after setting all properties.
function frecmod1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frecmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freccar1_Callback(hObject, eventdata, handles)
% hObject    handle to freccar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freccar1 as text
%        str2double(get(hObject,'String')) returns contents of freccar1 as a double


% --- Executes during object creation, after setting all properties.
function freccar1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freccar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Ejecucion punto 1
% --- Executes on button press in actionbtn.
function actionbtn_Callback(hObject, eventdata, handles)
% hObject    handle to actionbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global xt ct t FM FMT fourier_FM fourier_FMT fourier_eje fourier_ct fourier_xt demosign fourier_demosign

% Obtención de los parametros de entrada
selectedwavep1_content = get(handles.selectmenucar1, 'String');
selectedwavep1_value = selectedwavep1_content{get(handles.selectmenucar1, 'Value')};

temp_amod_p1 = get(handles.ampmod1, 'String');
amp_mod_p1 = onlyNumberCheck(temp_amod_p1{get(handles.ampmod1, 'Value')});

temp_fmod_p1 = get(handles.frecmod1, 'String');
frec_mod_p1 = onlyNumberCheck(temp_fmod_p1{get(handles.frecmod1, 'Value')});

temp_acar_p1 = get(handles.ampcar1, 'String');
amp_car_p1 = onlyNumberCheck(temp_acar_p1{get(handles.ampcar1, 'Value')});

temp_fcar_p1 = get(handles.freccar1, 'String');
frec_car_p1 = onlyNumberCheck(temp_fcar_p1{get(handles.freccar1, 'Value')});

% Verifica si todo esta correctamente seleccionado
try
    % Inicializamos los valores para nuestros ejes
    fs = frec_car_p1*4; % Frecuencia de muestreo
    T = 1/fs; % Periodo
    L = fs/2; % Cantidad de puntos
    t = (0:L-1)*T;
    
    % En base a la selección, crea la señal moduladora
    switch selectedwavep1_value
        case 'seno'
            xt = amp_mod_p1*sin(2*pi*frec_mod_p1.*t);
        case 'coseno'
            xt = amp_mod_p1*cos(2*pi*frec_mod_p1.*t);
        otherwise
            errordlg('Seleccione un tipo de señal moduladora', '¡Error de lectura!')
    end
    
    % Señal Portadora
    ct = amp_car_p1*cos(2*pi*frec_car_p1.*t);
    
    % Fourier de las señales portadora y moduladora
    L = length(t); 
    Y  = fft(ct, L)/L;
    fourier_ct = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(xt, L)/L;
    fourier_xt = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    % Creamos la señal FM a partir de la expresión matematica derivada de
    % la portadora.
    FM = xt.*ct;
    
    % Fourier de las señales
    Y  = fft(FM, L)/L;
    fourier_FM = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    fourier_eje = fs/2*linspace(-1,1,L);
    
    % Demodulacion
    FMT = FM.*ct;
    Y  = fft(FMT, L)/L;
    fourier_FMT = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    % Filtro paso bajo
    filt_lvl = 10; % Nivel del filtro
    filt_b = fir1(filt_lvl, (2*frec_car_p1)/fs); % Filtro
    demosign = filter(filt_b, 1, FMT); % Filtrado de la señal
    Y  = fft(demosign, L)/L;
    fourier_demosign = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    uiwait(msgbox('Por favor proceda al menu de selección para gráficar cada sección en su respectiva representación de tiempo y frecuencia', 'Modulacion Exitosa'));
catch e
    disp(e);
    uiwait(warndlg('Oops! Algo ha salido mal', '¡Error de calculo!'));
end

function p2ampmod1_Callback(hObject, eventdata, handles)
% hObject    handle to p2ampmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2ampmod1 as text
%        str2double(get(hObject,'String')) returns contents of p2ampmod1 as a double


% --- Executes during object creation, after setting all properties.
function p2ampmod1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2ampmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p2frecmod1_Callback(hObject, eventdata, handles)
% hObject    handle to p2frecmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2frecmod1 as text
%        str2double(get(hObject,'String')) returns contents of p2frecmod1 as a double


% --- Executes during object creation, after setting all properties.
function p2frecmod1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2frecmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p2ampmod2_Callback(hObject, eventdata, handles)
% hObject    handle to p2ampmod2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2ampmod2 as text
%        str2double(get(hObject,'String')) returns contents of p2ampmod2 as a double


% --- Executes during object creation, after setting all properties.
function p2ampmod2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2ampmod2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p2frecmod2_Callback(hObject, eventdata, handles)
% hObject    handle to p2frecmod2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2frecmod2 as text
%        str2double(get(hObject,'String')) returns contents of p2frecmod2 as a double


% --- Executes during object creation, after setting all properties.
function p2frecmod2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2frecmod2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p2ampcar1_Callback(hObject, eventdata, handles)
% hObject    handle to p2ampcar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2ampcar1 as text
%        str2double(get(hObject,'String')) returns contents of p2ampcar1 as a double


% --- Executes during object creation, after setting all properties.
function p2ampcar1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2ampcar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p2freccar1_Callback(hObject, eventdata, handles)
% hObject    handle to p2freccar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2freccar1 as text
%        str2double(get(hObject,'String')) returns contents of p2freccar1 as a double


% --- Executes during object creation, after setting all properties.
function p2freccar1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2freccar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btngraph1.
function btngraph1_Callback(hObject, eventdata, handles)
% hObject    handle to btngraph1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global xt t fourier_eje fourier_xt

% Graficamos en el 'axes' especificado
axes(handles.p1graphtime)
cla reset;
plot(t(1:length(t)/8), xt(1:length(t)/8))
axis tight
title('Señal Moduladora');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p1graphfourier)
cla reset;
plot(fourier_eje, fourier_xt)
axis tight
title('Transformada Fourier Señal Moduladora');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on


% --- Executes on button press in btngraph2.
function btngraph2_Callback(hObject, eventdata, handles)
% hObject    handle to btngraph2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global ct t fourier_eje fourier_ct

% Graficamos en el 'axes' especificado
axes(handles.p1graphtime)
cla reset;
plot(t(1:length(t)/8), ct(1:length(t)/8))
axis tight
title('Señal Portadora');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p1graphfourier)
cla reset;
plot(fourier_eje, fourier_ct)
axis tight
title('Transformada Fourier Señal Portadora');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on


% --- Executes on button press in btngraph3.
function btngraph3_Callback(hObject, eventdata, handles)
% hObject    handle to btngraph3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global t FM fourier_FM fourier_eje

% Graficamos en el 'axes' especificado
axes(handles.p1graphtime)
cla reset;
plot(t(1:length(t)/8), FM(1:length(t)/8))
axis tight
title('Señal Modulada');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p1graphfourier)
cla reset;
plot(fourier_eje, fourier_FM)
axis tight
title('Transformada Fourier Señal Modulada');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on


% --- Executes on button press in btngraph4.
function btngraph4_Callback(hObject, eventdata, handles)
% hObject    handle to btngraph4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global ct t fourier_eje fourier_ct

% Graficamos en el 'axes' especificado
axes(handles.p1graphtime)
cla reset;
plot(t(1:length(t)/8), ct(1:length(t)/8))
axis tight
title('Señal Portadora Demodulador');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p1graphfourier)
cla reset;
plot(fourier_eje, fourier_ct)
axis tight
title('Transformada Fourier Señal Portadora Demodulador');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in btngraph5.
function btngraph5_Callback(hObject, eventdata, handles)
% hObject    handle to btngraph5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global t FMT fourier_FMT fourier_eje

% Graficamos en el 'axes' especificado
axes(handles.p1graphtime)
cla reset;
plot(t(1:length(t)/8), FMT(1:length(t)/8))
axis tight
title('Señal Demodulada sin Filtro Pasa Bajos');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p1graphfourier)
cla reset;
plot(fourier_eje, fourier_FMT)
axis tight
title('Transformada Fourier Señal Demodulada sin Filtro Pasa Bajos');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on


% --- Executes on button press in btngraph6.
function btngraph6_Callback(hObject, eventdata, handles)
% hObject    handle to btngraph6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global t demosign fourier_eje fourier_demosign
axes(handles.p1graphtime)
cla reset;
plot(t(1:length(t)/8), demosign(1:length(t)/8))
axis tight
title('Señal Demodulada con Filtro Pasa Bajos');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p1graphfourier)
cla reset;
plot(fourier_eje, fourier_demosign)
axis tight
title('Transformada Fourier Señal Demodulada con Filtro Pasa Bajos');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

%% Ejecucion punto 2
% --- Executes on button press in p2btnaction.
function p2btnaction_Callback(hObject, eventdata, handles)
% hObject    handle to p2btnaction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p2xt1 p2xt2 p2ct1 p2ct2 p2t p3fourier_eje p2fourier_xt1 p2fourier_xt2 p2fourier_ct1 p2fourier_ct2
global QAM_1 QAM_2 QAM p2fourier_QAM_1 p2fourier_QAM_2 p2fourier_QAM
global DQAM_1 DQAM_2 p2fourier_DQAM_1 p2fourier_DQAM_2 rec1 rec2 fourier_rec1 fourier_rec2

p2amp_mod_1 = myNumberCheck(handles.p2ampmod1);
p2fre_mod_1 = myNumberCheck(handles.p2frecmod1);
p2amp_mod_2 = myNumberCheck(handles.p2ampmod2);
p2fre_mod_2 = myNumberCheck(handles.p2frecmod2);
p2amp_car_1 = myNumberCheck(handles.p2ampcar1);
p2fre_car_1 = myNumberCheck(handles.p2freccar1);

% Verifica si todo esta correctamente seleccionado
try
    % Inicializamos los valores para nuestros ejes
    fs = p2fre_car_1*8; % Frecuencia de muestreo
    T = 1/fs; % Periodo
    L = fs/2; % Cantidad de puntos
    p2t = (0:L-1)*T;
    
    % En base a la selección, crea la señal moduladora
    p2xt1 = p2amp_mod_1*sin(2*pi*p2fre_mod_1.*p2t);
    p2xt2 = p2amp_mod_2*sin(2*pi*p2fre_mod_2.*p2t);
    
    % Señales Portadoras
    p2ct1 = p2amp_car_1*cos(2*pi*p2fre_car_1.*p2t);
    p2ct2 = p2amp_car_1*sin(2*pi*p2fre_car_1.*p2t);
    
    % Fourier de las señales portadora y moduladora
    L = length(p2t); 
    p3fourier_eje = fs/2*linspace(-1,1,L);
    
    Y  = fft(p2ct1, L)/L;
    p2fourier_ct1 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p2ct2, L)/L;
    p2fourier_ct2 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p2xt1, L)/L;
    p2fourier_xt1 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p2xt2, L)/L;
    p2fourier_xt2 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    % Creamos la señal FM a partir de la expresión matematica derivada de
    % la portadora.
    QAM_1 = p2xt1.*p2ct1;
    QAM_2 = p2xt2.*p2ct2;
    QAM = QAM_1 + QAM_2;
    
    % Fourier de las señales
    Y  = fft(QAM_1, L)/L;
    p2fourier_QAM_1 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(QAM_2, L)/L;
    p2fourier_QAM_2 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(QAM, L)/L;
    p2fourier_QAM = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);

    % Demodulacion
    DQAM_1 = QAM.*p2ct1;
    Y  = fft(DQAM_1, L)/L;
    p2fourier_DQAM_1 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    DQAM_2 = QAM.*p2ct2;
    Y  = fft(DQAM_2, L)/L;
    p2fourier_DQAM_2 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    % Filtro paso bajo
    filt_lvl = 10;
    filt_a = fir1(filt_lvl, (p2fre_car_1 - p2fre_mod_1)/fs);
    filt_b = fir1(filt_lvl, (p2fre_car_1 - p2fre_mod_2)/fs);
    
    rec1 = filter(filt_a, 1, DQAM_1);
    rec2 = filter(filt_b, 1, DQAM_2);

    Y  = fft(rec1, L)/L;
    fourier_rec1 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(rec2, L)/L;
    fourier_rec2 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    uiwait(msgbox('Por favor proceda al menu de selección para gráficar cada sección en su respectiva representación de tiempo y frecuencia', 'Modulacion Exitosa'));
catch e
    disp(e);
    uiwait(warndlg('Oops! Algo ha salido mal', '¡Error de calculo!'));
end

% --- Executes on button press in p2btngraph1.
function p2btngraph1_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2xt1 p2t p3fourier_eje p2fourier_xt1

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), p2xt1(1:length(p2t)/8))
axis tight
title('Señal Moduladora 1');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_xt1)
axis tight
title('Transformada Fourier Moduladora 1');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph2.
function p2btngraph2_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2xt2 p2t p3fourier_eje p2fourier_xt2

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), p2xt2(1:length(p2t)/8))
axis tight
title('Señal Moduladora 2');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_xt2)
axis tight
title('Transformada Fourier Moduladora 2');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph3.
function p2btngraph3_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2ct1 p2t p3fourier_eje p2fourier_ct1

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), p2ct1(1:length(p2t)/8))
axis tight
title('Señal Portadora Senoidal');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_ct1)
axis tight
title('Transformada Fourier Portadora Senoidal');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph4.
function p2btngraph4_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2ct2 p2t p3fourier_eje p2fourier_ct2

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), p2ct2(1:length(p2t)/8))
axis tight
title('Señal Portadora Cosenoidal');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_ct2)
axis tight
title('Transformada Fourier Portadora Cosenoidal');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph5.
function p2btngraph5_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2t p3fourier_eje
global QAM_1 p2fourier_QAM_1

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), QAM_1(1:length(p2t)/8))
axis tight
title('Señal En Cuadratura Cosenoidal');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_QAM_1)
axis tight
title('Transformada Señal En Cuadratura Cosenoidal');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph6.
function p2btngraph6_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2t p3fourier_eje
global QAM_2 p2fourier_QAM_2

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), QAM_2(1:length(p2t)/8))
axis tight
title('Señal En Cuadratura Senoidal');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_QAM_2)
axis tight
title('Transformada Señal En Cuadratura Senoidal');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph7.
function p2btngraph7_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2t p3fourier_eje
global p2fourier_QAM QAM

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), QAM(1:length(p2t)/8))
axis tight
title('Señal Modulada en Cuadratura');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_QAM)
axis tight
title('Transformada Señal Modulada en Cuadratura');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph8.
function p2btngraph8_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2ct1 p2t p3fourier_eje p2fourier_ct1

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), p2ct1(1:length(p2t)/8))
axis tight
title('Señal Portadora Cosenoidal');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_ct1)
axis tight
title('Transformada Fourier Portadora Cosenoidal');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on


% --- Executes on button press in p2btngraph9.
function p2btngraph9_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2ct2 p2t p3fourier_eje p2fourier_ct2

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), p2ct2(1:length(p2t)/8))
axis tight
title('Señal Portadora Senoidal');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_ct2)
axis tight
title('Transformada Fourier Portadora Senoidal');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on


% --- Executes on button press in p2btngraph10.
function p2btngraph10_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2t p3fourier_eje
global DQAM_1 p2fourier_DQAM_1

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), DQAM_1(1:length(p2t)/8))
axis tight
title('Señal Demodulada en Cuadratura Cosenoidal');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_DQAM_1)
axis tight
title('Transformada Señal Demodulada en Cuadratura Cosenoidal');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph11.
function p2btngraph11_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2t p3fourier_eje
global DQAM_2 p2fourier_DQAM_2

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), DQAM_2(1:length(p2t)/8))
axis tight
title('Señal Demodulada en Cuadratura Senoidal');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, p2fourier_DQAM_2)
axis tight
title('Transformada Señal Demodulada en Cuadratura Senoidal');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph12.
function p2btngraph12_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2t p3fourier_eje
global rec1 fourier_rec1

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), rec1(1:length(p2t)/8))
axis tight
title('Señal Moduladora 1 Recuperada Filtro');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, fourier_rec1)
axis tight
title('Transformada Moduladora 1 Recuperada Filtro');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p2btngraph13.
function p2btngraph13_Callback(hObject, eventdata, handles)
% hObject    handle to p2btngraph13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p2t p3fourier_eje 
global rec2 fourier_rec2

axes(handles.p2graphtime)
cla reset;
plot(p2t(1:length(p2t)/8), rec2(1:length(p2t)/8))
axis tight
title('Señal Moduladora 2 Recuperada');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p2graphfourier)
cla reset;
plot(p3fourier_eje, fourier_rec2)
axis tight
title('Transformada Moduladora 2 Recuperada');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on



function p3ampmod1_Callback(hObject, eventdata, handles)
% hObject    handle to p3ampmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p3ampmod1 as text
%        str2double(get(hObject,'String')) returns contents of p3ampmod1 as a double


% --- Executes during object creation, after setting all properties.
function p3ampmod1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p3ampmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p3frecmod1_Callback(hObject, eventdata, handles)
% hObject    handle to p3frecmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p3frecmod1 as text
%        str2double(get(hObject,'String')) returns contents of p3frecmod1 as a double


% --- Executes during object creation, after setting all properties.
function p3frecmod1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p3frecmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p3ampmod2_Callback(hObject, eventdata, handles)
% hObject    handle to p3ampmod2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p3ampmod2 as text
%        str2double(get(hObject,'String')) returns contents of p3ampmod2 as a double


% --- Executes during object creation, after setting all properties.
function p3ampmod2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p3ampmod2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p3frecmod2_Callback(hObject, eventdata, handles)
% hObject    handle to p3frecmod2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p3frecmod2 as text
%        str2double(get(hObject,'String')) returns contents of p3frecmod2 as a double


% --- Executes during object creation, after setting all properties.
function p3frecmod2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p3frecmod2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p3ampmod3_Callback(hObject, eventdata, handles)
% hObject    handle to p3ampmod3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p3ampmod3 as text
%        str2double(get(hObject,'String')) returns contents of p3ampmod3 as a double


% --- Executes during object creation, after setting all properties.
function p3ampmod3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p3ampmod3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p3frecmod3_Callback(hObject, eventdata, handles)
% hObject    handle to p3frecmod3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p3frecmod3 as text
%        str2double(get(hObject,'String')) returns contents of p3frecmod3 as a double


% --- Executes during object creation, after setting all properties.
function p3frecmod3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p3frecmod3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in p3btnaction.
function p3btnaction_Callback(hObject, eventdata, handles)
% hObject    handle to p3btnaction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Variables globales
global p3t p3fourier_eje p3xt1 p3xt2 p3xt3 p3xtsum p3fourier_xt1 p3fourier_xt2 p3fourier_xt3 p3fourier_xtsum
global p3ct p3modSC p3modLC1 p3modLC2 p3modLC3 p3fourier_ct p3fourier_modSC p3fourier_modLC1 p3fourier_modLC2 p3fourier_modLC3 

p3amp_mod_1 = myNumberCheck(handles.p3ampmod1);
p3fre_mod_1 = myNumberCheck(handles.p3frecmod1);
p3amp_mod_2 = myNumberCheck(handles.p3ampmod2);
p3fre_mod_2 = myNumberCheck(handles.p3frecmod2);
p3amp_mod_3 = myNumberCheck(handles.p3ampmod3);
p3fre_mod_3 = myNumberCheck(handles.p3frecmod3);
p3fre_car = myNumberCheck(handles.p3freccar);

% Verifica si todo esta correctamente seleccionado
try
    % Inicializamos los valores para nuestros ejes
    fs = p3fre_car*4; % Frecuencia de muestreo
    T = 1/fs; % Periodo
    L = fs/2; % Cantidad de puntos
    p3t = (0:L-1)*T;
    
    % En base a la selección, crea la señal moduladora
    p3xt1 = p3amp_mod_1*sin(2*pi*p3fre_mod_1.*p3t);
    p3xt2 = p3amp_mod_2*sin(2*pi*p3fre_mod_2.*p3t);
    p3xt3 = p3amp_mod_3*sin(2*pi*p3fre_mod_3.*p3t);
    p3xtsum = p3xt1 + p3xt2 + p3xt3;
    % Señales Portadoras
    p3ct = cos(2*pi*p3fre_car.*p3t);
    p3modSC = (p3xtsum.*p3ct);
    p3modLC1 = (p3xtsum.*p3ct) + 0.5*p3ct;
    p3modLC2 = (p3xtsum.*p3ct) + 1.0*p3ct;
    p3modLC3 = (p3xtsum.*p3ct) + 1.2*p3ct;
    
    % Fourier de las señales portadora y moduladora
    L = length(p3t); 
    p3fourier_eje = fs/2*linspace(-1,1,L);
    
    Y  = fft(p3ct, L)/L;
    p3fourier_ct = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p3modSC, L)/L;
    p3fourier_modSC = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p3modLC1, L)/L;
    p3fourier_modLC1 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p3modLC2, L)/L;
    p3fourier_modLC2 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p3modLC3, L)/L;
    p3fourier_modLC3 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p3xt1, L)/L;
    p3fourier_xt1 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p3xt2, L)/L;
    p3fourier_xt2 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p3xt3, L)/L;
    p3fourier_xt3 = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    Y  = fft(p3xtsum, L)/L;
    p3fourier_xtsum = 2*abs([Y(L/2+2:end) Y(1:L/2+1)]);
    
    uiwait(msgbox('Por favor proceda al menu de selección para gráficar cada sección en su respectiva representación de tiempo y frecuencia', 'Modulacion Exitosa'));
catch e
    disp(e);
    uiwait(warndlg('Oops! Algo ha salido mal', '¡Error de calculo!'));
end


function p3freccar_Callback(hObject, eventdata, handles)
% hObject    handle to p3freccar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p3freccar as text
%        str2double(get(hObject,'String')) returns contents of p3freccar as a double


% --- Executes during object creation, after setting all properties.
function p3freccar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p3freccar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in p3btngraph1.
function p3btngraph1_Callback(hObject, eventdata, handles)
% hObject    handle to p3btngraph1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p3t p3fourier_eje p3xt1 p3fourier_xt1

axes(handles.p3graphtime)
cla reset;
plot(p3t(1:length(p3t)/8), p3xt1(1:length(p3t)/8))
axis tight
title('Señal Moduladora 1');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p3graphfourier)
cla reset;
plot(p3fourier_eje, p3fourier_xt1)
axis tight
title('Transformada Moduladora 1');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p3btngraph2.
function p3btngraph2_Callback(hObject, eventdata, handles)
% hObject    handle to p3btngraph2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p3t p3fourier_eje p3xt2 p3fourier_xt2

axes(handles.p3graphtime)
cla reset;
plot(p3t(1:length(p3t)/8), p3xt2(1:length(p3t)/8))
axis tight
title('Señal Moduladora 2');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p3graphfourier)
cla reset;
plot(p3fourier_eje, p3fourier_xt2)
axis tight
title('Transformada Moduladora 2');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p3btngraph3.
function p3btngraph3_Callback(hObject, eventdata, handles)
% hObject    handle to p3btngraph3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p3t p3fourier_eje p3xt3 p3fourier_xt3

axes(handles.p3graphtime)
cla reset;
plot(p3t(1:length(p3t)/8), p3xt3(1:length(p3t)/8))
axis tight
title('Señal Moduladora 3');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p3graphfourier)
cla reset;
plot(p3fourier_eje, p3fourier_xt3)
axis tight
title('Transformada Moduladora 3');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p3btngraph4.
function p3btngraph4_Callback(hObject, eventdata, handles)
% hObject    handle to p3btngraph4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p3t p3fourier_eje p3xtsum p3fourier_xtsum

axes(handles.p3graphtime)
cla reset;
plot(p3t(1:length(p3t)/8), p3xtsum(1:length(p3t)/8))
axis tight
title('Señal Sumatoria de Moduladoras');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p3graphfourier)
cla reset;
plot(p3fourier_eje, p3fourier_xtsum)
axis tight
title('Transformada Sumatoria de Moduladoras');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p3btngraph5.
function p3btngraph5_Callback(hObject, eventdata, handles)
% hObject    handle to p3btngraph5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p3t p3fourier_eje
global p3ct p3fourier_ct 

axes(handles.p3graphtime)
cla reset;
plot(p3t(1:length(p3t)/8), p3ct(1:length(p3t)/8))
axis tight
title('Señal Portadora');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p3graphfourier)
cla reset;
plot(p3fourier_eje, p3fourier_ct)
axis tight
title('Transformada Señal Portadora');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p3btngraph6.
function p3btngraph6_Callback(hObject, eventdata, handles)
% hObject    handle to p3btngraph6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p3t p3fourier_eje p3modSC p3fourier_modSC

axes(handles.p3graphtime)
cla reset;
plot(p3t(1:length(p3t)/8), p3modSC(1:length(p3t)/8))
axis tight
title('Señal DSB-SC');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p3graphfourier)
cla reset;
plot(p3fourier_eje, p3fourier_modSC)
axis tight
title('Transformada Señal DSB-SC');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p3btngraph7.
function p3btngraph7_Callback(hObject, eventdata, handles)
% hObject    handle to p3btngraph7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p3t p3fourier_eje p3modLC1 p3fourier_modLC1

axes(handles.p3graphtime)
cla reset;
plot(p3t(1:length(p3t)/8), p3modLC1(1:length(p3t)/8))
axis tight
title('Señal DSB-LC (0.5)');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p3graphfourier)
cla reset;
plot(p3fourier_eje, p3fourier_modLC1)
axis tight
title('Transformada Señal DSB-LC (0.5)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p3btngraph8.
function p3btngraph8_Callback(hObject, eventdata, handles)
% hObject    handle to p3btngraph8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p3t p3fourier_eje p3modLC2 p3fourier_modLC2

axes(handles.p3graphtime)
cla reset;
plot(p3t(1:length(p3t)/8), p3modLC2(1:length(p3t)/8))
axis tight
title('Señal DSB-LC (1.0)');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p3graphfourier)
cla reset;
plot(p3fourier_eje, p3fourier_modLC2)
axis tight
title('Transformada Señal DSB-LC (1.0)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on

% --- Executes on button press in p3btngraph9.
function p3btngraph9_Callback(hObject, eventdata, handles)
% hObject    handle to p3btngraph9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p3t p3fourier_eje p3modLC3 p3fourier_modLC3 

axes(handles.p3graphtime)
cla reset;
plot(p3t(1:length(p3t)/8), p3modLC3(1:length(p3t)/8))
axis tight
title('Señal DSB-LC (1.2)');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on

axes(handles.p3graphfourier)
cla reset;
plot(p3fourier_eje, p3fourier_modLC3)
axis tight
title('Transformada Señal DSB-LC (1.2)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (V/Hz)');
grid on
