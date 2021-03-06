function osp_set_metabolites(app)

value = app.IncludedMetabolitesDropDown.Value;
            
switch value
    case 'default'
        switch lower(app.MRSProtocolDropDown.Value)
            case 'brain'
                app.AlaCheckBox.Value = false;
                app.AlaCheckBox.Enable = 'Off';
                app.AscCheckBox.Value = true;
                app.AscCheckBox.Enable = 'Off';
                app.AspCheckBox.Value = true;
                app.AspCheckBox.Enable = 'Off';
                app.bHBCheckBox.Value = false;
                app.bHBCheckBox.Enable = 'Off';
                app.bHGCheckBox.Value = false;
                app.bHGCheckBox.Enable = 'Off';
                app.CitCheckBox.Value = false;
                app.CitCheckBox.Enable = 'Off';
                app.CrCheckBox.Value = true;
                app.CrCheckBox.Enable = 'Off';
                app.CrCH2CheckBox.Value = true;
                app.CrCH2CheckBox.Enable = 'Off';
                app.EtOHCheckBox.Value = false;
                app.EtOHCheckBox.Enable = 'Off';
                app.GABACheckBox.Value = true;
                app.GABACheckBox.Enable = 'Off';
                app.GPCCheckBox.Value = true;
                app.GPCCheckBox.Enable = 'Off';
                app.GSHCheckBox.Value = true;
                app.GSHCheckBox.Enable = 'Off';
                app.GlcCheckBox.Value = false;
                app.GlcCheckBox.Enable = 'Off';
                app.GlnCheckBox.Value = true;
                app.GlnCheckBox.Enable = 'Off';
                app.GluCheckBox.Value = true;
                app.GluCheckBox.Enable = 'Off';
                app.GlyCheckBox.Value = false;
                app.GlyCheckBox.Enable = 'Off';
                app.H2OCheckBox.Value = true;
                app.H2OCheckBox.Enable = 'Off';
                app.InsCheckBox.Value = true;
                app.InsCheckBox.Enable = 'Off';
                app.LacCheckBox.Value = true;
                app.LacCheckBox.Enable = 'Off';
                app.NAACheckBox.Value = true;
                app.NAACheckBox.Enable = 'Off';
                app.NAAGCheckBox.Value = true;
                app.NAAGCheckBox.Enable = 'Off';
                app.PChCheckBox.Value = true;
                app.PChCheckBox.Enable = 'Off';
                app.PCrCheckBox.Value = true;
                app.PCrCheckBox.Enable = 'Off';
                app.PECheckBox.Value = true;
                app.PECheckBox.Enable = 'Off';
                app.PhenylCheckBox.Value = false;
                app.PhenylCheckBox.Enable = 'Off';
                app.ScylloCheckBox.Value = true;
                app.ScylloCheckBox.Enable = 'Off';
                app.SerCheckBox.Value = false;
                app.SerCheckBox.Enable = 'Off';
                app.TauCheckBox.Value = true;
                app.TauCheckBox.Enable = 'Off';
                app.TyrosCheckBox.Value = false;
                app.TyrosCheckBox.Enable = 'Off';
                app.MM09CheckBox.Value = true;
                app.MM09CheckBox.Enable = 'Off';
                app.MM12CheckBox.Value = true;
                app.MM12CheckBox.Enable = 'Off';
                app.MM14CheckBox.Value = true;
                app.MM14CheckBox.Enable = 'Off';
                app.MM17CheckBox.Value = true;
                app.MM17CheckBox.Enable = 'Off';
                app.MM20CheckBox.Value = true;
                app.MM20CheckBox.Enable = 'Off';
                app.Lip09CheckBox.Value = true;
                app.Lip09CheckBox.Enable = 'Off';
                app.Lip13CheckBox.Value = true;
                app.Lip13CheckBox.Enable = 'Off';
                app.Lip20CheckBox.Value = true;
                app.Lip20CheckBox.Enable = 'Off';
            case 'braino phantom'
                app.AlaCheckBox.Value = false;
                app.AlaCheckBox.Enable = 'Off';
                app.AscCheckBox.Value = false;
                app.AscCheckBox.Enable = 'Off';
                app.AspCheckBox.Value = false;
                app.AspCheckBox.Enable = 'Off';
                app.bHBCheckBox.Value = false;
                app.bHBCheckBox.Enable = 'Off';
                app.bHGCheckBox.Value = false;
                app.bHGCheckBox.Enable = 'Off';
                app.CitCheckBox.Value = false;
                app.CitCheckBox.Enable = 'Off';
                app.CrCheckBox.Value = true;
                app.CrCheckBox.Enable = 'Off';
                app.CrCH2CheckBox.Value = true;
                app.CrCH2CheckBox.Enable = 'Off';
                app.EtOHCheckBox.Value = false;
                app.EtOHCheckBox.Enable = 'Off';
                app.GABACheckBox.Value = false;
                app.GABACheckBox.Enable = 'Off';
                app.GPCCheckBox.Value = false;
                app.GPCCheckBox.Enable = 'Off';
                app.GSHCheckBox.Value = false;
                app.GSHCheckBox.Enable = 'Off';
                app.GlcCheckBox.Value = false;
                app.GlcCheckBox.Enable = 'Off';
                app.GlnCheckBox.Value = false;
                app.GlnCheckBox.Enable = 'Off';
                app.GluCheckBox.Value = true;
                app.GluCheckBox.Enable = 'Off';
                app.GlyCheckBox.Value = false;
                app.GlyCheckBox.Enable = 'Off';
                app.H2OCheckBox.Value = true;
                app.H2OCheckBox.Enable = 'Off';
                app.InsCheckBox.Value = true;
                app.InsCheckBox.Enable = 'Off';
                app.LacCheckBox.Value = true;
                app.LacCheckBox.Enable = 'Off';
                app.NAACheckBox.Value = true;
                app.NAACheckBox.Enable = 'Off';
                app.NAAGCheckBox.Value = false;
                app.NAAGCheckBox.Enable = 'Off';
                app.PChCheckBox.Value = true;
                app.PChCheckBox.Enable = 'Off';
                app.PCrCheckBox.Value = false;
                app.PCrCheckBox.Enable = 'Off';
                app.PECheckBox.Value = false;
                app.PECheckBox.Enable = 'Off';
                app.PhenylCheckBox.Value = false;
                app.PhenylCheckBox.Enable = 'Off';
                app.ScylloCheckBox.Value = false;
                app.ScylloCheckBox.Enable = 'Off';
                app.SerCheckBox.Value = false;
                app.SerCheckBox.Enable = 'Off';
                app.TauCheckBox.Value = false;
                app.TauCheckBox.Enable = 'Off';
                app.TyrosCheckBox.Value = false;
                app.TyrosCheckBox.Enable = 'Off';
                app.MM09CheckBox.Value = false;
                app.MM09CheckBox.Enable = 'Off';
                app.MM12CheckBox.Value = false;
                app.MM12CheckBox.Enable = 'Off';
                app.MM14CheckBox.Value = false;
                app.MM14CheckBox.Enable = 'Off';
                app.MM17CheckBox.Value = false;
                app.MM17CheckBox.Enable = 'Off';
                app.MM20CheckBox.Value = false;
                app.MM20CheckBox.Enable = 'Off';
                app.Lip09CheckBox.Value = false;
                app.Lip09CheckBox.Enable = 'Off';
                app.Lip13CheckBox.Value = false;
                app.Lip13CheckBox.Enable = 'Off';
                app.Lip20CheckBox.Value = false;
                app.Lip20CheckBox.Enable = 'Off';
        end
    case 'full'
        app.AlaCheckBox.Value = true;
        app.AlaCheckBox.Enable = 'Off';
        app.AscCheckBox.Value = true;
        app.AscCheckBox.Enable = 'Off';
        app.AspCheckBox.Value = true;
        app.AspCheckBox.Enable = 'Off';
        app.bHBCheckBox.Value = true;
        app.bHBCheckBox.Enable = 'Off';
        app.bHGCheckBox.Value = true;
        app.bHGCheckBox.Enable = 'Off';
        app.CitCheckBox.Value = true;
        app.CitCheckBox.Enable = 'Off';
        app.CrCheckBox.Value = true;
        app.CrCheckBox.Enable = 'Off';
        app.CrCH2CheckBox.Value = true;
        app.CrCH2CheckBox.Enable = 'Off';
        app.EtOHCheckBox.Value = true;
        app.EtOHCheckBox.Enable = 'Off';
        app.GABACheckBox.Value = true;
        app.GABACheckBox.Enable = 'Off';
        app.GPCCheckBox.Value = true;
        app.GPCCheckBox.Enable = 'Off';
        app.GSHCheckBox.Value = true;
        app.GSHCheckBox.Enable = 'Off';
        app.GlcCheckBox.Value = true;
        app.GlcCheckBox.Enable = 'Off';
        app.GlnCheckBox.Value = true;
        app.GlnCheckBox.Enable = 'Off';
        app.GluCheckBox.Value = true;
        app.GluCheckBox.Enable = 'Off';
        app.GlyCheckBox.Value = true;
        app.GlyCheckBox.Enable = 'Off';
        app.H2OCheckBox.Value = true;
        app.H2OCheckBox.Enable = 'Off';
        app.InsCheckBox.Value = true;
        app.InsCheckBox.Enable = 'Off';
        app.LacCheckBox.Value = true;
        app.LacCheckBox.Enable = 'Off';
        app.NAACheckBox.Value = true;
        app.NAACheckBox.Enable = 'Off';
        app.NAAGCheckBox.Value = true;
        app.NAAGCheckBox.Enable = 'Off';
        app.PChCheckBox.Value = true;
        app.PChCheckBox.Enable = 'Off';
        app.PCrCheckBox.Value = true;
        app.PCrCheckBox.Enable = 'Off';
        app.PECheckBox.Value = true;
        app.PECheckBox.Enable = 'Off';
        app.PhenylCheckBox.Value = true;
        app.PhenylCheckBox.Enable = 'Off';
        app.ScylloCheckBox.Value = true;
        app.ScylloCheckBox.Enable = 'Off';
        app.SerCheckBox.Value = true;
        app.SerCheckBox.Enable = 'Off';
        app.TauCheckBox.Value = true;
        app.TauCheckBox.Enable = 'Off';
        app.TyrosCheckBox.Value = true;
        app.TyrosCheckBox.Enable = 'Off';
        app.MM09CheckBox.Value = true;
        app.MM09CheckBox.Enable = 'Off';
        app.MM12CheckBox.Value = true;
        app.MM12CheckBox.Enable = 'Off';
        app.MM14CheckBox.Value = true;
        app.MM14CheckBox.Enable = 'Off';
        app.MM17CheckBox.Value = true;
        app.MM17CheckBox.Enable = 'Off';
        app.MM20CheckBox.Value = true;
        app.MM20CheckBox.Enable = 'Off';
        app.Lip09CheckBox.Value = true;
        app.Lip09CheckBox.Enable = 'Off';
        app.Lip13CheckBox.Value = true;
        app.Lip13CheckBox.Enable = 'Off';
        app.Lip20CheckBox.Value = true;
        app.Lip20CheckBox.Enable = 'Off';
    case 'custom'
        app.AlaCheckBox.Enable = 'On';
        app.AscCheckBox.Enable = 'On';
        app.AspCheckBox.Enable = 'On';
        app.bHBCheckBox.Enable = 'On';
        app.bHGCheckBox.Enable = 'On';
        app.CitCheckBox.Enable = 'On';
        app.CrCheckBox.Enable = 'Off';
        app.CrCH2CheckBox.Enable = 'On';
        app.EtOHCheckBox.Enable = 'On';
        app.GABACheckBox.Enable = 'On';
        app.GPCCheckBox.Enable = 'Off';
        app.GSHCheckBox.Enable = 'On';
        app.GlcCheckBox.Enable = 'On';
        app.GlnCheckBox.Enable = 'On';
        app.GluCheckBox.Enable = 'Off';
        app.GlyCheckBox.Enable = 'On';
        app.H2OCheckBox.Enable = 'On';
        app.InsCheckBox.Enable = 'Off';
        app.LacCheckBox.Enable = 'On';
        app.NAACheckBox.Enable = 'Off';
        app.NAAGCheckBox.Enable = 'On';
        app.PChCheckBox.Enable = 'On';
        app.PCrCheckBox.Enable = 'On';
        app.PECheckBox.Enable = 'On';
        app.PhenylCheckBox.Enable = 'On';
        app.ScylloCheckBox.Enable = 'On';
        app.SerCheckBox.Enable = 'On';
        app.TauCheckBox.Enable = 'On';
        app.TyrosCheckBox.Enable = 'On';
        app.MM09CheckBox.Enable = 'On';
        app.MM12CheckBox.Enable = 'On';
        app.MM14CheckBox.Enable = 'On';
        app.MM17CheckBox.Enable = 'On';
        app.MM20CheckBox.Enable = 'On';
        app.Lip09CheckBox.Enable = 'On';
        app.Lip13CheckBox.Enable = 'On';
        app.Lip20CheckBox.Enable = 'On';
end