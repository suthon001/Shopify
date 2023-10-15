/// <summary>
/// ControlReady.
/// </summary>
controladdin Wysiwyg
{
    //VerticalStretch = true;
    HorizontalStretch = true;
    MinimumHeight = 500;
    RequestedHeight = 500;
    Scripts = 'src/Scripts/ckeditor.js', 'src/Scripts/MainScript.js';
    StartupScript = 'src/Scripts/startupScript.js';
    RecreateScript = 'src/Scripts/recreateScript.js';
    RefreshScript = 'src/Scripts/refreshScript.js';
    /// <summary>
    /// ControlReady.
    /// </summary>
    event ControlReady();
    /// <summary>
    /// SaveRequested.
    /// </summary>
    /// <param name="data">Text.</param>
    event SaveRequested(data: Text);
    /// <summary>
    /// OnAfterInit.
    /// </summary>
    event ContentChanged();
    /// <summary>
    /// OnAfterInit.
    /// </summary>
    event OnAfterInit();

    procedure Init();
    procedure Load(data: Text);
    procedure RequestSave();
    procedure SetReadOnly(readonly: boolean);
}