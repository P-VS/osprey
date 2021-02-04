function osp_iniQuantifyWindow(gui)
%% osp_iniQuantifyWindow
%   This function creates the initial quantify window in the gui.
%
%
%   USAGE:
%       osp_iniQuantifyWindow(gui);
%
%   INPUT:      gui      = gui class containing all handles and the MRSCont 
%
%   OUTPUT:     Changes in gui parameters and MRSCont are written into the
%               gui class
%
%
%   AUTHORS:
%       Dr. Helge Zoellner (Johns Hopkins University, 2020-01-16)
%       hzoelln2@jhmi.edu
%
%   CREDITS:
%       This code is based on numerous functions from the FID-A toolbox by
%       Dr. Jamie Near (McGill University)
%       https://github.com/CIC-methods/FID-A
%       Simpson et al., Magn Reson Med 77:23-33 (2017)
%
%   HISTORY:
%       2020-01-16: First version of the code.
%%% 1. GET HANDLES %%%

% This function creates the initial quantify window
        MRSCont = getappdata(gui.figure,'MRSCont'); % Get MRSCont from hidden container in gui class
        gui.layout.tabs.TabEnables{5} = 'on';
        gui.layout.tabs.Selection  = 5;
        gui.layout.EmptyQuantPlot = 0;
        
        %%% 2. CREATING SUB TABS FOR THIS TAB %%%%
% In this case one tab fo each fit (off,sum,diff1,diff2,ref,water)
         gui.layout.quantifyTab.TabWidth   = 115;
         for t = 1 : gui.quant.Number.Model %Create tabs depending on the number of fits
                gui.layout.(['quantTab' gui.quant.Names.Model{t}]) = uix.VBox('Parent', gui.layout.quantifyTab,...
                                                                               'BackgroundColor',gui.colormap.Background);
                gui.layout.quantifyTabhandles{t} = ['quantTab' gui.quant.Names.Model{t}];
         end
        gui.layout.quantifyTab.TabTitles  = gui.quant.Names.Model;
        
%%% 3. FILLING INFO PANEL FOR THIS TAB %%%
if ~(isfield(MRSCont.flags,'isPRIAM') || isfield(MRSCont.flags,'isMRSI')) || ~(MRSCont.flags.isPRIAM || MRSCont.flags.isMRSI)
        for t = 1 : gui.quant.Number.Model %Loop over fits
            gui.upperBox.quant.Info = uix.Panel('Parent', gui.layout.(gui.layout.quantifyTabhandles{t}), 'Padding', 5, ...
                                      'Title', ['Actual file: ' MRSCont.files{gui.controls.Selected}],...
                                      'FontName', 'Arial','HighlightColor', gui.colormap.Foreground,'BackgroundColor',gui.colormap.Background,...
                                      'ForegroundColor', gui.colormap.Foreground, 'ShadowColor', gui.colormap.Foreground);
            % Creates layout for plotting and data control
            gui.Plot.quant = uix.HBox('Parent', gui.layout.(gui.layout.quantifyTabhandles{t}),'BackgroundColor',gui.colormap.Background);
            set(gui.layout.(gui.layout.quantifyTabhandles{t}), 'Heights', [-0.1 -0.9]);
            % Get parameter from file to fill the info panel
           StatText = ['Sequence: ' gui.load.Names.Seq '; Fitting algorithm: ' MRSCont.opts.fit.method  '; Fitting Style: ' MRSCont.opts.fit.style ...
                         '\nSelected subspecs: ' gui.quant.Names.Model{gui.quant.Selected.Model} ];
                     gui.InfoText.quant  = uicontrol('Parent',gui.upperBox.quant.Info,'style','text',...
                'FontSize', 12, 'FontName', 'Arial','HorizontalAlignment', 'left', 'String', sprintf(StatText),...
                'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);

% In this case a table is created based on a uicontol slider
            gui.quant.Number.Quants = length(fieldnames(MRSCont.quantify.tables.(gui.quant.Names.Model{t})));
            gui.quant.Names.Quants = fieldnames(MRSCont.quantify.tables.(gui.quant.Names.Model{t}));
            QuantText = cell(length(MRSCont.quantify.metabs.(gui.quant.Names.Model{t}))+1,gui.quant.Number.Quants);
            QuantText{1,1} = 'Metabolite';
            QuantText(2:end,1) = MRSCont.quantify.metabs.(gui.quant.Names.Model{t})';
                for q = 1 : gui.quant.Number.Quants % Collect all results
                    QuantText(1,q+1) = gui.quant.Names.Quants(q);
                    if (strcmp(gui.quant.Names.Quants(q),'AlphaCorrWaterScaled') || strcmp(gui.quant.Names.Quants(q),'AlphaCorrWaterScaledGroupNormed')) && isfield(MRSCont.quantify.tables.(gui.quant.Names.Model{t}),'AlphaCorrWaterScaled')                       
                        idx_GABA  = find(strcmp(MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model}),'GABA'));
                        if strcmp(MRSCont.opts.fit.coMM3, 'none')                            
                                    tempQuantText = cell(length(MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model})),1);
                                    tempQuantText(idx_GABA) = table2cell(MRSCont.quantify.tables.(gui.quant.Names.Model{gui.quant.Selected.Model}).(gui.quant.Names.Quants{q}).Voxel_1(gui.controls.Selected,:))';
                        else                              
                                     tempQuantText = cell(length(MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model})),1);
                                     tempQuants = MRSCont.quantify.tables.(gui.quant.Names.Model{gui.quant.Selected.Model}).(gui.quant.Names.Quants{q}).Voxel_1(gui.controls.Selected,:);
                                     tempQuantText(idx_GABA) = table2cell(tempQuants(1,1));
                                     idx_GABAp  = find(strcmp(MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model}),'GABAplus'));
                                     tempQuantText(idx_GABAp) = table2cell(tempQuants(1,2));
                        end                         
                        QuantText(2:end,q+1) = tempQuantText;
                    else
                        QuantText(2:end,q+1) = table2cell(MRSCont.quantify.tables.(gui.quant.Names.Model{t}).(gui.quant.Names.Quants{q}).Voxel_1(gui.controls.Selected,:))';
                    end
                end
            temp=uimulticollist ( 'units', 'normalized', 'position', [0 0 1 1], 'string', QuantText,...
                'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
            set ( temp, 'BackgroundColor',gui.colormap.Background);
            set( temp, 'Parent', gui.Plot.quant);
        end
else       

% All the information from the Raw data is read out here
        for t = 1 : gui.quant.Number.Model %Loop over fits
            gui.upperBox.quant.box = uix.HBox('Parent', gui.layout.(gui.layout.quantifyTabhandles{t}),'BackgroundColor',gui.colormap.Background,'Spacing',5);
                gui.upperBox.quant.upperLeftButtons = uix.Panel('Parent', gui.upperBox.quant.box, ...
                                         'Padding', 5, 'Title', ['Navigate voxel'],...
                                         'FontName', 'Arial', 'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground,...
                                         'HighlightColor', gui.colormap.Foreground, 'ShadowColor', gui.colormap.Foreground);
                gui.controls.Buttonbox = uix.HBox('Parent',gui.upperBox.quant.upperLeftButtons, 'BackgroundColor',gui.colormap.Background);
                gui.controls.navigate_RawTab = uix.Grid('Parent',gui.controls.Buttonbox,'BackgroundColor',gui.colormap.Background);
                gui.controls.text_x = uicontrol(gui.controls.navigate_RawTab,'Style','text','String','X:',...
                    'FontName', 'Arial', 'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
                gui.controls.text_y = uicontrol(gui.controls.navigate_RawTab,'Style','text','String','Y:',...
                    'FontName', 'Arial', 'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
                gui.controls.text_z = uicontrol(gui.controls.navigate_RawTab,'Style','text','String','Z:',...
                    'FontName', 'Arial', 'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
                gui.controls.b_left_x = uicontrol(gui.controls.navigate_RawTab,'Style','PushButton', 'BackgroundColor',gui.colormap.Background,'String','<');
                gui.controls.b_left_y = uicontrol(gui.controls.navigate_RawTab,'Style','PushButton', 'BackgroundColor',gui.colormap.Background,'String','<');
                gui.controls.b_left_z = uicontrol(gui.controls.navigate_RawTab,'Style','PushButton', 'BackgroundColor',gui.colormap.Background,'String','<');
                set(gui.controls.b_left_x,'Callback',{@osp_onLeftX,gui});
                set(gui.controls.b_left_y,'Callback',{@osp_onLeftY,gui});
                set(gui.controls.b_left_z,'Callback',{@osp_onLeftZ,gui});
                if gui.info.nXvoxels <= 1
                    gui.controls.b_left_x.Enable = 'off';
                end
                if gui.info.nYvoxels <= 1
                    gui.controls.b_left_y.Enable = 'off';
                end
                if gui.info.nZvoxels <= 1
                    gui.controls.b_left_z.Enable = 'off';
                end
                gui.controls.text_act_x = uicontrol(gui.controls.navigate_RawTab,'Style','text','String','1',...
                    'FontName', 'Arial', 'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
                gui.controls.text_act_y = uicontrol(gui.controls.navigate_RawTab,'Style','text','String','1',...
                    'FontName', 'Arial', 'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
                gui.controls.text_act_z = uicontrol(gui.controls.navigate_RawTab,'Style','text','String','1',...
                    'FontName', 'Arial', 'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
                gui.controls.b_right_x = uicontrol(gui.controls.navigate_RawTab,'Style','PushButton', 'BackgroundColor',gui.colormap.Background,'String','>');
                gui.controls.b_right_y = uicontrol(gui.controls.navigate_RawTab,'Style','PushButton', 'BackgroundColor',gui.colormap.Background,'String','>');
                gui.controls.b_right_z = uicontrol(gui.controls.navigate_RawTab,'Style','PushButton', 'BackgroundColor',gui.colormap.Background,'String','>');
                set(gui.controls.b_right_x,'Callback',{@osp_onRightX,gui});
                set(gui.controls.b_right_y,'Callback',{@osp_onRightY,gui});
                set(gui.controls.b_right_z,'Callback',{@osp_onRightZ,gui});
                if gui.info.nXvoxels <= 1
                    gui.controls.b_right_x.Enable = 'off';
                end
                if gui.info.nYvoxels <= 1
                    gui.controls.b_right_y.Enable = 'off';
                end
                if gui.info.nZvoxels <= 1
                    gui.controls.b_right_z.Enable = 'off';
                end   
                set( gui.controls.navigate_RawTab, 'Widths', [-20 -30 -20 -30], 'Heights', [-33 -33 -33] );
            gui.upperBox.quant.Info = uix.Panel('Parent', gui.upperBox.quant.box, 'Padding', 5, ...
                                      'Title', ['Actual file: ' MRSCont.files{gui.controls.Selected}],...
                                      'FontName', 'Arial','HighlightColor', gui.colormap.Foreground,'BackgroundColor',gui.colormap.Background,...
                                      'ForegroundColor', gui.colormap.Foreground, 'ShadowColor', gui.colormap.Foreground);
            % Creates layout for plotting and data control
            gui.Plot.quant = uix.HBox('Parent', gui.layout.(gui.layout.quantifyTabhandles{t}),'BackgroundColor',gui.colormap.Background);
            set(gui.layout.(gui.layout.quantifyTabhandles{t}), 'Heights', [-0.1 -0.9]);
            % Get parameter from file to fill the info panel
           StatText = ['Voxel ' num2str(gui.controls.act_x) ' Sequence: ' gui.load.Names.Seq '; Fitting algorithm: ' MRSCont.opts.fit.method  '; Fitting Style: ' MRSCont.opts.fit.style ...
                         '\nSelected subspecs: ' gui.quant.Names.Model{gui.quant.Selected.Model} ];
                     gui.InfoText.quant  = uicontrol('Parent',gui.upperBox.quant.Info,'style','text',...
                'FontSize', 12, 'FontName', 'Arial','HorizontalAlignment', 'left', 'String', sprintf(StatText),...
                'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
            set(gui.upperBox.quant.box, 'Width', [-0.1 -0.9]);  
% In this case a table is created based on a uicontol slider
            gui.quant.Number.Quants = length(fieldnames(MRSCont.quantify.tables.(gui.quant.Names.Model{t})));
            gui.quant.Names.Quants = fieldnames(MRSCont.quantify.tables.(gui.quant.Names.Model{t}));
            QuantText = cell(length(MRSCont.quantify.metabs.(gui.quant.Names.Model{t}))+1,gui.quant.Number.Quants);
            QuantText{1,1} = 'Metabolite';
            QuantText(2:end,1) = MRSCont.quantify.metabs.(gui.quant.Names.Model{t})';
                for q = 1 : gui.quant.Number.Quants % Collect all results
                    QuantText(1,q+1) = gui.quant.Names.Quants(q);
                    if (strcmp(gui.quant.Names.Quants(q),'AlphaCorrWaterScaled') || strcmp(gui.quant.Names.Quants(q),'AlphaCorrWaterScaledGroupNormed')) && isfield(MRSCont.quantify.tables.(gui.quant.Names.Model{t}),'AlphaCorrWaterScaled')                       
                        idx_GABA  = find(strcmp(MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model}),'GABA'));
                        if strcmp(MRSCont.opts.fit.coMM3, 'none')                            
                                    tempQuantText = cell(length(MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model})),1);
                                    tempQuantText(idx_GABA) = table2cell(MRSCont.quantify.tables.(gui.quant.Names.Model{gui.quant.Selected.Model}).(gui.quant.Names.Quants{q}).(['Voxel_' num2str(gui.controls.act_x)])(gui.controls.Selected,:))';
                        else                              
                                     tempQuantText = cell(length(MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model})),1);
                                     tempQuants = MRSCont.quantify.tables.(gui.quant.Names.Model{gui.quant.Selected.Model}).(gui.quant.Names.Quants{q}).(['Voxel_' num2str(gui.controls.act_x)])(gui.controls.Selected,:);
                                     tempQuantText(idx_GABA) = table2cell(tempQuants(1,1));
                                     idx_GABAp  = find(strcmp(MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model}),'GABAplus'));
                                     tempQuantText(idx_GABAp) = table2cell(tempQuants(1,2));
                        end                         
                        QuantText(2:end,q+1) = tempQuantText;
                    else
                        QuantText(2:end,q+1) = table2cell(MRSCont.quantify.tables.(gui.quant.Names.Model{t}).(gui.quant.Names.Quants{q}).(['Voxel_' num2str(gui.controls.act_x)])(gui.controls.Selected,:))';
                    end
                end
            temp=uimulticollist ( 'units', 'normalized', 'position', [0 0 1 1], 'string', QuantText,...
                'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
            set ( temp, 'BackgroundColor',gui.colormap.Background);
            set( temp, 'Parent', gui.Plot.quant);
        end 
end
        setappdata(gui.figure,'MRSCont',MRSCont); % Write MRSCont into hidden container in gui class
end