package Processors.Game.Lobby.TopOrganization
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Organization.TBaseOrganizationMember;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.TopOrganization.Componets.TUIMemberItem;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowOrganizationJoin extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_Items:uint = 10;
      
      protected const Sign_RandomSelect:uint = 1;
      
      protected const Sign_Reset:uint = 2;
      
      protected var FTF_Explanation:TextField;
      
      protected var FMC_Members:Sprite;
      
      protected var FMC_JoinSequence:Sprite;
      
      protected var FUIPageMembers:TUIPage;
      
      protected var FUIPageJoinSequence:TUIPage;
      
      protected var FMC_RandomSelect:MovieClip;
      
      protected var FMC_Reset:MovieClip;
      
      protected var FMC_ConfirmJoin:MovieClip;
      
      protected var FUIMemberItems:Vector.<TUIMemberItem>;
      
      protected var FUIJoinSequenceItems:Vector.<TUIMemberItem>;
      
      protected var FPageMemberIndex:int;
      
      protected var FPageJoinIndex:int;
      
      protected var FJoinMemberListDataVect:Vector.<TBaseOrganizationMember>;
      
      protected var FOrgMemberListDataVect:Vector.<TBaseOrganizationMember>;
      
      protected var FOrgMemberListClone:Vector.<TBaseOrganizationMember>;
      
      protected var FOrganizationJoinMinMembers:uint;
      
      protected var FOrganizationJoinMaxMembers:uint;
      
      protected var FOrganizationMemberMinLevel:uint;
      
      protected var FLoginTime:uint;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FType:uint;
      
      protected var FConfirmJoinOnClick:Function;
      
      public function TProcessorWindowOrganizationJoin(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FUIPageMembers = new TUIPage(this);
         this.FUIPageJoinSequence = new TUIPage(this);
         this.FUIMemberItems = new Vector.<TUIMemberItem>(this.CAPACITY_Items);
         this.FUIJoinSequenceItems = new Vector.<TUIMemberItem>(this.CAPACITY_Items);
         this.FJoinMemberListDataVect = new Vector.<TBaseOrganizationMember>();
         this.FOrgMemberListClone = new Vector.<TBaseOrganizationMember>();
         this.FPageMemberIndex = 0;
         this.FPageJoinIndex = 0;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPORGANIZATION.RESOURCESID_Swf_TopOrganization);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_OrganizationJoin) as Sprite;
         TGameUtil.AddWindowMask(this);
         UIDispatch();
         this.FTF_Explanation = FMainUI["TF_Explanation"];
         this.FMC_Members = FMainUI["MC_Members"];
         this.FMC_JoinSequence = FMainUI["MC_JoinSequence"];
         this.FMC_RandomSelect = FMainUI["MC_RandomSelect"];
         TGameUtil.setButtonMode(this.FMC_RandomSelect,true);
         this.FMC_Reset = FMainUI["MC_Reset"];
         TGameUtil.setButtonMode(this.FMC_Reset,true);
         this.FMC_ConfirmJoin = FMainUI["MC_ConfirmJoin"];
         TGameUtil.setButtonMode(this.FMC_ConfirmJoin,true);
         this.SetUIPage(this.FMC_Members,this.FUIPageMembers);
         this.SetUIPage(this.FMC_JoinSequence,this.FUIPageJoinSequence);
         this.SetUIItem(this.FMC_Members,this.FUIMemberItems,CONST_TOPORGANIZATION.TYPE_Member);
         this.SetUIItem(this.FMC_JoinSequence,this.FUIJoinSequenceItems,CONST_TOPORGANIZATION.TYPE_Join);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.JoinOnOk;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
      }
      
      protected function SetUIPage(param1:Sprite, param2:TUIPage) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         _loc3_ = param1["MC_ChangePage"]["MC_PageLeft"];
         param2.ButtonPrevious.Substrate = _loc3_;
         _loc3_ = param1["MC_ChangePage"]["MC_PageRight"];
         param2.ButtonNext.Substrate = _loc3_;
         _loc4_ = param1["MC_ChangePage"]["TF_Page"];
         param2.LabelPage = _loc4_;
         param2.PageSize = this.CAPACITY_Items;
         param2.Init();
      }
      
      protected function SetUIItem(param1:Sprite, param2:Vector.<TUIMemberItem>, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TUIMemberItem = null;
         _loc5_ = this.CAPACITY_Items;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = new TUIMemberItem(this);
            _loc6_.Resource = param1["MC_Member_" + _loc4_] as MovieClip;
            _loc6_.Tag = _loc4_;
            _loc6_.Type = param3;
            _loc6_.UIItemOnClick = this.ProcessorUIItemOnClick;
            _loc6_.Init();
            param2[_loc4_] = _loc6_;
            _loc4_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         UILocations();
         this.FUIPageMembers.OnChangePage = this.MemberPageOnChange;
         this.FUIPageJoinSequence.OnChangePage = this.JoinSequencePageOnChange;
         this.FMC_RandomSelect.addEventListener(MouseEvent.CLICK,this.ButtonRandomSelectOnClick,false,0,true);
         this.FMC_Reset.addEventListener(MouseEvent.CLICK,this.ButtonResetOnClick,false,0,true);
         this.FMC_ConfirmJoin.addEventListener(MouseEvent.CLICK,this.ButtonConfirmJoinOnClick,false,0,true);
         this.FOrganizationJoinMinMembers = this.GetConfigValue(CONST_CONFIGVALUE.GVG_Fst_Signup_PlayerNumber_Min);
         this.FOrganizationJoinMaxMembers = this.GetConfigValue(CONST_CONFIGVALUE.GVG_Fst_Signup_PlayerNumber_Max);
         this.FOrganizationMemberMinLevel = this.GetConfigValue(CONST_CONFIGVALUE.GVG_Fst_Signup_PlayerLv_Min);
         this.FLoginTime = 3 * 24 * 60 * 60;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_03) as TSystemLanguage;
         this.FTF_Explanation.htmlText = _loc1_.Desc;
         super.ResourcesPerform_UILocations();
      }
      
      protected function GetConfigValue(param1:uint) : uint
      {
         var _loc2_:TConfigValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,param1) as TConfigValue;
         if(_loc2_ != null)
         {
            return _loc2_.Value as uint;
         }
         return 0;
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FUIPageMembers.TotalQuantity = this.FOrgMemberListClone.length;
         if(this.FUIPageMembers.TotalQuantity == this.CAPACITY_Items)
         {
            this.FPageMemberIndex = 0;
         }
         this.FUIPageMembers.PageIndex = this.FPageMemberIndex;
         this.FUIPageMembers.Update();
         this.FUIPageJoinSequence.TotalQuantity = this.FJoinMemberListDataVect.length;
         if(this.FUIPageJoinSequence.TotalQuantity == this.CAPACITY_Items)
         {
            this.FPageJoinIndex = 0;
         }
         this.FUIPageJoinSequence.PageIndex = this.FPageJoinIndex;
         this.FUIPageJoinSequence.Update();
      }
      
      protected function UpdateOrgMemberList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TBaseOrganizationMember = null;
         var _loc4_:TBaseOrganizationMember = null;
         _loc2_ = this.FOrgMemberListClone.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FOrgMemberListClone.pop();
            _loc1_++;
         }
         this.FOrgMemberListClone.length = 0;
         _loc2_ = this.FOrgMemberListDataVect.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FOrgMemberListDataVect[_loc1_];
            this.FOrgMemberListClone.push(_loc3_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FOrgMemberListClone.length)
         {
            _loc3_ = this.FOrgMemberListClone[_loc1_];
            if(_loc3_ != null)
            {
               if(_loc3_.PlayerLevel < this.FOrganizationMemberMinLevel || STimingCore.GetServerTime() - _loc3_.LastLogginTime > this.FLoginTime)
               {
                  this.FOrgMemberListClone.splice(_loc1_,1);
                  _loc1_ = -1;
               }
            }
            _loc1_++;
         }
      }
      
      protected function SortByLevel(param1:TBaseOrganizationMember, param2:TBaseOrganizationMember) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _loc3_ = param1.PlayerLevel;
         _loc4_ = param2.PlayerLevel;
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         _loc5_ = param1.PlayerOrgPower.ToNumber();
         _loc6_ = param2.PlayerOrgPower.ToNumber();
         if(_loc5_ > _loc6_)
         {
            return -1;
         }
         if(_loc5_ < _loc6_)
         {
            return 1;
         }
         return 0;
      }
      
      protected function UpdateUIMember() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIMemberItem = null;
         var _loc5_:TBaseOrganizationMember = null;
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FUIMemberItems[_loc1_];
            _loc4_.Resource.visible = false;
            _loc4_.Context = null;
            _loc1_++;
         }
         this.FOrgMemberListClone.sort(this.SortByLevel);
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_ + this.FPageMemberIndex * this.CAPACITY_Items;
            if(_loc3_ >= this.FOrgMemberListClone.length)
            {
               break;
            }
            _loc5_ = this.FOrgMemberListClone[_loc3_];
            _loc4_ = this.FUIMemberItems[_loc1_];
            _loc4_.Tag = _loc3_;
            _loc4_.Context = _loc5_;
            _loc4_.Resource.visible = true;
            _loc4_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateUIJoin() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIMemberItem = null;
         var _loc5_:TBaseOrganizationMember = null;
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FUIJoinSequenceItems[_loc1_];
            _loc4_.Resource.visible = false;
            _loc4_.Context = null;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_Items;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_ + this.FPageJoinIndex * this.CAPACITY_Items;
            if(_loc3_ >= this.FJoinMemberListDataVect.length)
            {
               break;
            }
            _loc5_ = this.FJoinMemberListDataVect[_loc3_];
            _loc4_ = this.FUIJoinSequenceItems[_loc1_];
            _loc4_.Tag = _loc3_;
            _loc4_.Context = _loc5_;
            _loc4_.Resource.visible = true;
            _loc4_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateTextExplanation(param1:uint) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(CONST_TOPORGANIZATION.TYPE_GVG1_Join == param1)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_03) as TSystemLanguage;
            this.FTF_Explanation.htmlText = _loc2_.Desc;
         }
         else if(CONST_TOPORGANIZATION.TYPE_GVG2_Join == param1)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_STRING_11) as TSystemLanguage;
            this.FTF_Explanation.htmlText = _loc2_.Desc;
         }
      }
      
      override protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FType == CONST_TOPORGANIZATION.TYPE_GVG1_Join)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_Tips_05) as TSystemLanguage;
         }
         else if(this.FType == CONST_TOPORGANIZATION.TYPE_GVG2_Join)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_Tips_07) as TSystemLanguage;
         }
         if(_loc2_ != null)
         {
            FHelpTips.Content = _loc2_.Desc;
         }
         else
         {
            FHelpTips.Content = "";
         }
         super.ButtonHelpOnOver(param1);
      }
      
      override protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         this.ButtonResetOnClick(null);
         _loc3_ = this.FJoinMemberListDataVect.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FJoinMemberListDataVect.pop();
            _loc2_++;
         }
         this.FJoinMemberListDataVect.length = 0;
         super.ButtonCloseOnClick(param1);
      }
      
      protected function ButtonRandomSelectOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TBaseOrganizationMember = null;
         _loc3_ = this.FOrgMemberListClone.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FOrgMemberListClone.shift();
            this.FJoinMemberListDataVect.push(_loc4_);
            _loc2_++;
         }
         this.UpdatePageInfo();
         this.UpdateUIJoin();
         this.UpdateUIMember();
         this.UpdateTextExplanation(this.FType);
      }
      
      protected function ButtonResetOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TBaseOrganizationMember = null;
         _loc3_ = this.FJoinMemberListDataVect.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FJoinMemberListDataVect.pop();
            this.FOrgMemberListClone.push(_loc4_);
            _loc2_++;
         }
         this.Update();
      }
      
      protected function ButtonConfirmJoinOnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         if(this.FJoinMemberListDataVect.length == 0)
         {
            EffectGenerateText(STRING_TOPORGANIZATION.STRING_NoJoinMember);
            return;
         }
         _loc4_ = this.FJoinMemberListDataVect.length;
         if(_loc4_ < this.FOrganizationJoinMinMembers)
         {
            EffectGenerateText(STRING_TOPORGANIZATION.STRING_JoinMemberMinLimited);
         }
         else if(_loc4_ <= this.FOrganizationJoinMaxMembers)
         {
            _loc3_ = this.FOrgMemberListDataVect.length - _loc4_;
            if(_loc3_ > 0)
            {
               _loc2_ = TUtilityString.Format(STRING_TOPORGANIZATION.FORMAT_RestPeople,_loc3_);
            }
            else
            {
               _loc2_ = STRING_TOPORGANIZATION.STRING_JoinQuest;
            }
            this.FUIWindowConfirmation.Text = _loc2_;
            this.FUIWindowConfirmation.visible = true;
         }
         else
         {
            EffectGenerateText(STRING_TOPORGANIZATION.STRING_JoinMemberMaxLimited);
         }
      }
      
      protected function ProcessorUIItemOnClick(param1:Object, param2:uint) : void
      {
         var _loc3_:TUIMemberItem = null;
         var _loc4_:TBaseOrganizationMember = null;
         var _loc5_:Boolean = false;
         _loc3_ = param1 as TUIMemberItem;
         _loc4_ = _loc3_.Context as TBaseOrganizationMember;
         if(param2 == CONST_TOPORGANIZATION.TYPE_Member)
         {
            _loc5_ = this.FindElement(this.FOrgMemberListClone,_loc4_);
            if(_loc5_)
            {
               this.FJoinMemberListDataVect.push(_loc4_);
            }
         }
         else if(param2 == CONST_TOPORGANIZATION.TYPE_Join)
         {
            _loc5_ = this.FindElement(this.FJoinMemberListDataVect,_loc4_);
            if(_loc5_)
            {
               this.FOrgMemberListClone.push(_loc4_);
            }
         }
         this.Update();
      }
      
      protected function FindElement(param1:Vector.<TBaseOrganizationMember>, param2:TBaseOrganizationMember) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = param1.indexOf(param2);
         if(_loc3_ != -1)
         {
            param1.splice(_loc3_,1);
            return true;
         }
         return false;
      }
      
      protected function MemberPageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageMemberIndex)
         {
            return;
         }
         this.FPageMemberIndex = param2;
         this.UpdateUIMember();
      }
      
      protected function JoinSequencePageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageJoinIndex)
         {
            return;
         }
         this.FPageJoinIndex = param2;
         this.UpdateUIJoin();
      }
      
      protected function JoinOnOk(param1:Object) : void
      {
         if(this.FConfirmJoinOnClick != null)
         {
            this.FConfirmJoinOnClick(this,this.FJoinMemberListDataVect);
         }
         this.ButtonCloseOnClick(null);
      }
      
      public function get ConfirmJoinOnClick() : Function
      {
         return this.FConfirmJoinOnClick;
      }
      
      public function set ConfirmJoinOnClick(param1:Function) : void
      {
         this.FConfirmJoinOnClick = param1;
      }
      
      public function Update(param1:uint = 0) : void
      {
         this.FType = param1;
         this.UpdatePageInfo();
         this.UpdateUIJoin();
         this.UpdateUIMember();
         this.UpdateTextExplanation(param1);
      }
      
      public function SetOrgMemberListData(param1:Vector.<TBaseOrganizationMember>) : void
      {
         this.FOrgMemberListDataVect = param1;
         this.UpdateOrgMemberList();
      }
      
      public function Reset() : void
      {
         this.FPageMemberIndex = 0;
         this.FPageJoinIndex = 0;
      }
   }
}

