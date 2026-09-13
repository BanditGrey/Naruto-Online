package Processors.Game.Lobby.Organization.Part
{
   import Components.ComboBox.TComboBox;
   import Components.Pages.TUIPage;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Organization.TBaseOrganiztionList;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Organization.Component.TUIOrgMemberListElement;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_ORGANIZATION;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TComponentOrganizationListPart extends TUIComponent
   {
      
      protected static const MAX_ORGLISTELEMENT_COUNT:uint = 14;
      
      protected var FIsInitialization:Boolean;
      
      protected var FMC:MovieClip;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FMC_PageLeft:MovieClip;
      
      protected var FMC_PageRight:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FBTN_Search:SimpleButton;
      
      protected var FTXT_InputOrgName:TextField;
      
      protected var FMcOrgListElement:TUIOrgMemberListElement;
      
      protected var FMCBtn_CreateOrg:MovieClip;
      
      protected var FMC_ComboBox:TComboBox;
      
      protected var FMC_OrgListElementVect:Vector.<TUIOrgMemberListElement>;
      
      protected var FBAddOrg:Boolean;
      
      protected var FOrgListData:Vector.<TBaseOrganiztionList>;
      
      protected var FChangeListData:Vector.<TBaseOrganiztionList>;
      
      protected var FTypeList:Vector.<DisplayObject>;
      
      protected var FTypeFamily:uint;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FSelectPageIndex:int;
      
      protected var FBFocus:Boolean;
      
      protected var FClickCreateOrg:Function;
      
      public function TComponentOrganizationListPart(param1:TUIComponent)
      {
         super(param1);
         this.FBAddOrg = true;
         this.FOrgListData = new Vector.<TBaseOrganiztionList>();
         this.FMC_OrgListElementVect = new Vector.<TUIOrgMemberListElement>();
         this.FChangeListData = new Vector.<TBaseOrganiztionList>();
         this.FUIPage = new TUIPage(this);
         this.FPageIndex = 0;
         this.FBFocus = false;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIOrgMemberListElement = null;
         var _loc5_:Vector.<String> = null;
         var _loc6_:DisplayObject = null;
         this.FMC = param1;
         addChild(this.FMC);
         this.FMC_ChangePage = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_ChangePage];
         this.FMC_PageLeft = this.FMC_ChangePage[CONST_ORGANIZATION.RESOURCE_Link_MC_PageLeft];
         this.FMC_PageRight = this.FMC_ChangePage[CONST_ORGANIZATION.RESOURCE_Link_MC_PageRight];
         this.FTF_Page = this.FMC_ChangePage[CONST_ORGANIZATION.RESOURCE_Link_TF_Page];
         this.FBTN_Search = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_BTN_Search];
         this.FMCBtn_CreateOrg = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_McBtn_CreateOrg];
         this.FTXT_InputOrgName = this.FMC["TXT_InputOrgName"];
         this.FTXT_InputOrgName.addEventListener(FocusEvent.FOCUS_IN,this.OnTextFocusIn);
         this.FTXT_InputOrgName.addEventListener(FocusEvent.FOCUS_OUT,this.OnTextFocusOut);
         this.FTypeList = new Vector.<DisplayObject>();
         _loc5_ = STRING_COMMON.FamilyNames;
         _loc2_ = 0;
         while(_loc2_ < _loc5_.length)
         {
            if(_loc2_ == 0)
            {
               _loc6_ = this.MakeComboItem(STRING_ORGANIZATION.STRING_All);
            }
            else
            {
               _loc6_ = this.MakeComboItem(_loc5_[_loc2_]);
            }
            this.FTypeList.push(_loc6_);
            _loc2_++;
         }
         this.FTypeFamily = SLogicsCore.Character.Country;
         this.FMC_ComboBox = new TComboBox(this,this.FMC["MC_ComboBox"],this.FTypeList,50,this.OnFamilySelect,false);
         TGameUtil.setButtonMode(this.FMCBtn_CreateOrg,true);
         this.SetButtonStatus();
         this.ResourcesPerform_UILocations();
         _loc2_ = 0;
         while(_loc2_ < MAX_ORGLISTELEMENT_COUNT)
         {
            _loc4_ = new TUIOrgMemberListElement(this);
            _loc4_.Perform_UIDispatch(this.FMC[CONST_ORGANIZATION.RESOURCE_Link_MC_OrgListElement + _loc2_]);
            this.FMC_OrgListElementVect[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMC_PageRight;
         this.FUIPage.PageSize = MAX_ORGLISTELEMENT_COUNT;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Search.addEventListener(MouseEvent.CLICK,this.OnSearchClick);
         this.FMCBtn_CreateOrg.addEventListener(MouseEvent.CLICK,this.OnCreatOrgClick);
      }
      
      protected function SetButtonStatus() : void
      {
         if(this.FBAddOrg)
         {
            this.FMCBtn_CreateOrg.visible = true;
         }
         else
         {
            this.FMCBtn_CreateOrg.visible = false;
         }
      }
      
      protected function UpdateList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIOrgMemberListElement = null;
         this.FChangeListData.sort(this.SortOnOrgList);
         _loc2_ = int(this.FChangeListData.length);
         _loc1_ = 0;
         while(_loc1_ < MAX_ORGLISTELEMENT_COUNT)
         {
            if(_loc1_ < _loc2_)
            {
               this.FMC_OrgListElementVect[_loc1_].UpDateElement(this.FChangeListData[_loc1_],this.FPageIndex * MAX_ORGLISTELEMENT_COUNT + _loc1_ + 1,this.FBAddOrg);
               this.FMC_OrgListElementVect[_loc1_].MC.visible = true;
            }
            else
            {
               this.FMC_OrgListElementVect[_loc1_].MC.visible = false;
            }
            _loc1_++;
         }
         this.FUIPage.TotalQuantity = this.FChangeListData.length;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
         if(this.FBAddOrg)
         {
            this.FMCBtn_CreateOrg.visible = false;
         }
         else
         {
            this.FMCBtn_CreateOrg.visible = true;
         }
      }
      
      protected function SortOnOrgList(param1:TBaseOrganiztionList, param2:TBaseOrganiztionList) : Number
      {
         if(param1.OrgLevel < param2.OrgLevel)
         {
            return 1;
         }
         if(param1.OrgLevel > param2.OrgLevel)
         {
            return -1;
         }
         return 0;
      }
      
      protected function SelectOnOrgList(param1:uint, param2:String = "") : Vector.<TBaseOrganiztionList>
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<TBaseOrganiztionList> = null;
         _loc5_ = new Vector.<TBaseOrganiztionList>();
         _loc4_ = int(this.FOrgListData.length);
         if(param2 != "")
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               if(this.FOrgListData[_loc3_].OrgName == param2)
               {
                  _loc5_.push(this.FOrgListData[_loc3_]);
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               if(this.FOrgListData[_loc3_].OrgFamily == param1)
               {
                  _loc5_.push(this.FOrgListData[_loc3_]);
               }
               _loc3_++;
            }
         }
         return _loc5_;
      }
      
      protected function OnFamilySelect(param1:Object, param2:uint) : void
      {
         var _loc3_:uint = 0;
         this.FPageIndex = 0;
         if(param2 == 0)
         {
            this.FChangeListData = this.FOrgListData;
         }
         else
         {
            _loc3_ = param2;
            this.FChangeListData = this.SelectOnOrgList(_loc3_);
         }
         this.UpdateList();
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_FamilyList") as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 != null)
         {
         }
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         _loc5_ = int(this.FChangeListData.length);
         _loc3_ = 0;
         while(_loc3_ < MAX_ORGLISTELEMENT_COUNT)
         {
            _loc4_ = this.FPageIndex * MAX_ORGLISTELEMENT_COUNT + _loc3_;
            if(_loc4_ < _loc5_)
            {
               if(this.FChangeListData[_loc4_] != null)
               {
                  this.FMC_OrgListElementVect[_loc3_].MC.visible = true;
                  this.FMC_OrgListElementVect[_loc3_].UpDateElement(this.FChangeListData[_loc4_],_loc4_ + 1,this.FBAddOrg);
               }
            }
            else
            {
               this.FMC_OrgListElementVect[_loc3_].MC.visible = false;
            }
            _loc3_++;
         }
      }
      
      protected function OnSearchClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FTXT_InputOrgName.text;
         if(_loc2_ != "")
         {
            this.FPageIndex = 0;
            this.FChangeListData = this.SelectOnOrgList(0,_loc2_);
            this.UpdateList();
         }
      }
      
      protected function OnCreatOrgClick(param1:MouseEvent) : void
      {
         if(this.FClickCreateOrg == null)
         {
            return;
         }
         this.FClickCreateOrg(this);
      }
      
      protected function OnTextFocusIn(param1:FocusEvent) : void
      {
         if(!this.FBFocus)
         {
            this.FTXT_InputOrgName.text = "";
            this.FBFocus = true;
         }
      }
      
      protected function OnTextFocusOut(param1:FocusEvent) : void
      {
         if(this.FTXT_InputOrgName.text == "")
         {
            this.FBFocus = false;
         }
      }
      
      public function get ClickCreateOrg() : Function
      {
         return this.FClickCreateOrg;
      }
      
      public function set ClickCreateOrg(param1:Function) : void
      {
         this.FClickCreateOrg = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FIsInitialization = true;
      }
      
      public function UpDateOrgList(param1:Object, param2:Vector.<TBaseOrganiztionList>, param3:Boolean) : void
      {
         this.FMC_ComboBox.SetChildSelectByIndex(this.FTypeFamily);
         this.FBAddOrg = param3;
         this.FOrgListData = param2;
         this.FChangeListData = this.SelectOnOrgList(this.FTypeFamily);
         this.UpdateList();
      }
      
      public function Unmount() : void
      {
         this.FPageIndex = 0;
      }
   }
}

