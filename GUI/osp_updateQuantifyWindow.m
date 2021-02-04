function osp_updateQuantifyWindow(gui)
%% osp_updateQuantifyWindow
%   This function updates the quantify tab.
%
%
%   USAGE:
%       osp_updateQuantifyWindow(gui);
%
%   INPUT:  
%           gui      = gui class containing all handles and the MRSCont             
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
%%% 1. INITIALIZE %%%
        MRSCont = getappdata(gui.figure,'MRSCont');  % Get MRSCont from hidden container in gui class
        gui.layout.EmptyQuantPlot = 0;
        if ~(isfield(MRSCont.flags,'isPRIAM') || isfield(MRSCont.flags,'isMRSI')) || ~(MRSCont.flags.isPRIAM || MRSCont.flags.isMRSI)
            gui.upperBox.quant.Info = gui.layout.(gui.layout.quantifyTabhandles{gui.quant.Selected.Model}).Children(2);
            gui.Plot.quant = gui.layout.(gui.layout.quantifyTabhandles{gui.quant.Selected.Model}).Children(1);
            gui.InfoText.quant = gui.layout.(gui.layout.quantifyTabhandles{gui.quant.Selected.Model}).Children(2).Children;
            StatText = ['Sequence: ' gui.load.Names.Seq '; Fitting algorithm: ' MRSCont.opts.fit.method  '; Fitting Style: ' MRSCont.opts.fit.style ...
                         '\nSelected subspecs: ' gui.quant.Names.Model{gui.quant.Selected.Model} ];
        else
            gui.upperBox.quant.Info = gui.layout.(gui.layout.quantifyTabhandles{gui.quant.Selected.Model}).Children(2).Children(1);          
            set(gui.layout.(gui.layout.quantifyTabhandles{gui.quant.Selected.Model}).Children(2).Children(2).Children.Children.Children(4),'String',gui.controls.act_z)
            set(gui.layout.(gui.layout.quantifyTabhandles{gui.quant.Selected.Model}).Children(2).Children(2).Children.Children.Children(5),'String',gui.controls.act_y)
            set(gui.layout.(gui.layout.quantifyTabhandles{gui.quant.Selected.Model}).Children(2).Children(2).Children.Children.Children(6),'String',gui.controls.act_x)
            gui.Plot.quant = gui.layout.(gui.layout.quantifyTabhandles{gui.quant.Selected.Model}).Children(1);
            gui.InfoText.quant = gui.layout.(gui.layout.quantifyTabhandles{gui.quant.Selected.Model}).Children(2).Children(1).Children;
            StatText = ['Voxel ' num2str(gui.controls.act_x) ': Sequence: ' gui.load.Names.Seq '; Fitting algorithm: ' MRSCont.opts.fit.method  '; Fitting Style: ' MRSCont.opts.fit.style ...
                         '\nSelected subspecs: ' gui.quant.Names.Model{gui.quant.Selected.Model} ];
        end
     
%%% 2. FILLING INFO PANEL FOR THIS TAB %%%
% All the information from the Raw data is read out here           
        set(gui.InfoText.quant, 'String',sprintf(StatText))
%%% 3. VISUALIZATION PART OF THIS TAB %%%
        gui.quant.Number.Quants = length(fieldnames(MRSCont.quantify.tables.(gui.quant.Names.Model{gui.quant.Selected.Model})));
        gui.quant.Names.Quants = fieldnames(MRSCont.quantify.tables.(gui.quant.Names.Model{gui.quant.Selected.Model}));
        QuantText = cell(length(MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model}))+1,gui.quant.Number.Quants);
        QuantText{1,1} = 'Metabolite';
        QuantText(2:end,1) = MRSCont.quantify.metabs.(gui.quant.Names.Model{gui.quant.Selected.Model})';
       if ~(isfield(MRSCont.flags,'isPRIAM') || isfield(MRSCont.flags,'isMRSI')) || ~(MRSCont.flags.isPRIAM || MRSCont.flags.isMRSI)
           for q = 1 : gui.quant.Number.Quants %Collect all results
                QuantText(1,q+1) = gui.quant.Names.Quants(q);
                if strcmp(gui.quant.Names.Quants(q),'AlphaCorrWaterScaled') || strcmp(gui.quant.Names.Quants(q),'AlphaCorrWaterScaledGroupNormed')
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
                    QuantText(2:end,q+1) = table2cell(MRSCont.quantify.tables.(gui.quant.Names.Model{gui.quant.Selected.Model}).(gui.quant.Names.Quants{q}).Voxel_1(gui.controls.Selected,:))';
                end
            end
            temp=uimulticollist ( 'units', 'normalized', 'position', [0 0 1 1], 'string', QuantText,...
                'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
             set( temp, 'BackgroundColor',gui.colormap.Background);
            delete(gui.Plot.quant.Children)
            set( temp, 'Parent', gui.Plot.quant ); %Update table
            set(gui.upperBox.quant.Info,'Title', ['Actual file: ' MRSCont.files{gui.controls.Selected}]); %Update info Title
        else
              for q = 1 : gui.quant.Number.Quants %Collect all results
                QuantText(1,q+1) = gui.quant.Names.Quants(q);
                if strcmp(gui.quant.Names.Quants(q),'AlphaCorrWaterScaled') || strcmp(gui.quant.Names.Quants(q),'AlphaCorrWaterScaledGroupNormed')
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
                    QuantText(2:end,q+1) = table2cell(MRSCont.quantify.tables.(gui.quant.Names.Model{gui.quant.Selected.Model}).(gui.quant.Names.Quants{q}).(['Voxel_' num2str(gui.controls.act_x)])(gui.controls.Selected,:))';
                end
            end
            temp=uimulticollist ( 'units', 'normalized', 'position', [0 0 1 1], 'string', QuantText,...
                'BackgroundColor',gui.colormap.Background,'ForegroundColor', gui.colormap.Foreground);
             set( temp, 'BackgroundColor',gui.colormap.Background);
            delete(gui.Plot.quant.Children)
            set( temp, 'Parent', gui.Plot.quant ); %Update table
            set(gui.upperBox.quant.Info,'Title', ['Actual file: ' MRSCont.files{gui.controls.Selected}]); %Update info Title
        end
        setappdata(gui.figure,'MRSCont',MRSCont);  % Write MRSCont into hidden container in gui class
end