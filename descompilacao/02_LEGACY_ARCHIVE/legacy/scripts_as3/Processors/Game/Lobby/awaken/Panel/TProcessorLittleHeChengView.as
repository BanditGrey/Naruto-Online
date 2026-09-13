package Processors.Game.Lobby.awaken.Panel
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TAwakenConfig;
   import Logics.DatebaseVO.VO.TAwakenSkillClassification;
   import Logics.DatebaseVO.VO.TAwakenSkillConfig;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.awaken.cell.BaseCell;
   import Processors.Game.Lobby.awaken.date.AwakenDateCELL;
   import Processors.Game.Lobby.awaken.date.AwakenLogicDate;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_AWAKEN;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorLittleHeChengView
   {
      
      public static const TEN:int = 9;
      
      public static const THREE:int = 3;
      
      public static const FIVE:int = 5;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FUITabSkill:TUITab;
      
      protected var FCurSkillTabIndex:int;
      
      protected var FCurSkillTabHeChengIndex:int;
      
      protected var FMC_TabHeCheng:MovieClip = null;
      
      protected var FHeChengPage:TUIPage = null;
      
      protected var FHeChengPageIndex:int;
      
      protected var FHeChengPageIndexCopy:int;
      
      protected var FMC_HeChengBtn:MovieClip = null;
      
      protected var FCurNeedHeChengDate:AwakenDateCELL = null;
      
      protected var FHeChengShowCount:int = 1;
      
      protected var FMainSlot:BaseCell = null;
      
      protected var FMC_Slot_Name:TextField;
      
      protected var FSlotVec:Vector.<BaseCell> = null;
      
      protected var FCurVec:Vector.<AwakenDateCELL> = null;
      
      protected var FMC_SkillName:Vector.<MovieClip> = null;
      
      protected var FTF_SkillName:Vector.<TextField> = null;
      
      protected var FTFSkillNameVec:Vector.<TextField> = null;
      
      protected var FTAwakenSkillConfig:Vector.<TAwakenSkillConfig> = null;
      
      protected var FAwakenDatas:AwakenLogicDate;
      
      protected var FCurPeiZhiDate:TAwakenSkillClassification = null;
      
      protected var CurDateBins:TBins = null;
      
      protected var FMC_ReduceBtn:SimpleButton = null;
      
      protected var FMC_addBtn:SimpleButton = null;
      
      protected var FBTN_Max:MovieClip = null;
      
      protected var FTF_Count:TextField = null;
      
      protected var FTF_Cost:TextField = null;
      
      protected var FTF_SkillDec:TextField = null;
      
      protected var FMax:int;
      
      protected var FTF_CommonCount:TextField;
      
      protected var FTF_CommonDesc:TextField;
      
      protected var FBtn_CheckBox:MovieClip;
      
      protected var FMC_Selected:MovieClip;
      
      protected var FMC_UnSelect:MovieClip;
      
      protected var FIsSelected:Boolean;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FIsFirst:Boolean;
      
      protected var FAllNeed:int;
      
      protected var FCanUse:Boolean;
      
      protected var FBtnClickBack:Function;
      
      protected var FBackOver:Function;
      
      protected var FBackOut:Function;
      
      protected var FBackMove:Function;
      
      public function TProcessorLittleHeChengView(param1:TUIComponent)
      {
         super();
         this.FUITabSkill = new TUITab(param1);
         this.FHeChengPage = new TUIPage(param1);
         this.FSlotVec = new Vector.<BaseCell>(THREE);
         this.FTAwakenSkillConfig = new Vector.<TAwakenSkillConfig>(FIVE);
         this.FMC_SkillName = new Vector.<MovieClip>(FIVE);
         this.FTFSkillNameVec = new Vector.<TextField>(THREE);
         this.FTF_SkillName = new Vector.<TextField>(FIVE);
         this.FAwakenDatas = SLogicsCore.AwakenDate;
         this.CurDateBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_AwakenSkillClassification);
         this.FCurNeedHeChengDate = new AwakenDateCELL();
         this.FUIWindowConfirmation = new TUIWindowConfirmation(param1.Parent);
         this.FIsFirst = true;
         this.FCanUse = true;
      }
      
      public function SetPanel(param1:MovieClip) : void
      {
         this.FHeChengShowCount = 1;
         this.FThisPanel = param1;
         this.InitilizationView();
      }
      
      public function InitilizationView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:BaseCell = null;
         this.FMC_HeChengBtn = this.FThisPanel["MC_HeChengBtn"];
         TGameUtil.setButtonMode(this.FMC_HeChengBtn,true);
         this.FMC_ReduceBtn = this.FThisPanel["MC_ChangeCount"]["BTN_Reduce"];
         this.FMC_addBtn = this.FThisPanel["MC_ChangeCount"]["BTN_Add"];
         this.FBTN_Max = this.FThisPanel["MC_ChangeCount"]["Btn_Max"];
         TGameUtil.setButtonMode(this.FBTN_Max,true);
         this.FTF_Count = this.FThisPanel["MC_ChangeCount"]["TF_Count"];
         this.FTF_Count.restrict = "0-9";
         this.FTF_Count.maxChars = 4;
         this.FTF_Cost = this.FThisPanel["TF_Cost"];
         this.FTF_SkillDec = this.FThisPanel["TF_SkillDec"];
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            _loc3_ = new BaseCell();
            _loc3_.SetPanel(this.FThisPanel["MC_Slot_" + _loc1_]);
            _loc3_.BackOver = this.FBackOver;
            _loc3_.BackOut = this.FBackOut;
            _loc3_.BackMove = this.FBackMove;
            this.FSlotVec[_loc1_] = _loc3_;
            this.FTFSkillNameVec[_loc1_] = this.FThisPanel["MC_Slot_Name_" + _loc1_];
            _loc1_++;
         }
         this.FMainSlot = new BaseCell();
         this.FMainSlot.BackOver = this.FBackOver;
         this.FMainSlot.BackOut = this.FBackOut;
         this.FMainSlot.BackMove = this.FBackMove;
         this.FMainSlot.SetPanel(this.FThisPanel["MC_Slot_"]);
         this.FMC_Slot_Name = this.FThisPanel["MC_Slot_Name"];
         _loc1_ = 0;
         while(_loc1_ < TEN)
         {
            _loc2_ = this.FThisPanel["MC_Tab_" + _loc1_];
            if(_loc1_ >= this.CurDateBins.Count)
            {
               _loc2_.visible = false;
            }
            else
            {
               _loc2_.visible = true;
               this.FUITabSkill.SetTabByIndex(_loc2_,_loc1_);
               this.FUITabSkill.SetTabCaptionByIndex("",_loc1_);
            }
            _loc1_++;
         }
         this.FUITabSkill.OnSwitch = this.TabSkillOnSwitch;
         this.FUITabSkill.Init();
         this.FHeChengPage.ButtonPrevious.Substrate = this.FThisPanel["MC_Page"]["MC_PageLeft"];
         this.FHeChengPage.ButtonNext.Substrate = this.FThisPanel["MC_Page"]["MC_PageRight"];
         this.FHeChengPage.LabelPage = this.FThisPanel["MC_Page"]["TF_Page"];
         TextField(this.FThisPanel["MC_Page"]["TF_Page"]).text = "0/0";
         this.FHeChengPage.PageSize = TEN;
         this.FHeChengPage.Init();
         this.FHeChengPage.OnChangePage = this.HeChengOnChange;
         this.FMC_HeChengBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_ReduceBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_addBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FBTN_Max.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FTF_Count.addEventListener(Event.CHANGE,this.HandleInPut);
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            this.FMC_SkillName[_loc1_] = this.FThisPanel["MC_SkillName_" + _loc1_];
            this.FTF_SkillName[_loc1_] = this.FMC_SkillName[_loc1_]["TF_SkillName"];
            this.FMC_SkillName[_loc1_].buttonMode = true;
            this.FMC_SkillName[_loc1_].addEventListener(MouseEvent.CLICK,this.HandleMcClick);
            this.FMC_SkillName[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.HandleMcOver);
            this.FMC_SkillName[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.HandleMcOut);
            this.FMC_SkillName[_loc1_].mouseChildren = false;
            _loc1_++;
         }
         this.FTF_CommonCount = this.FThisPanel["TF_CommonCount"];
         this.FTF_CommonDesc = this.FThisPanel["TF_CommonDesc"];
         this.FTF_CommonDesc.text = "";
         this.FBtn_CheckBox = this.FThisPanel[CONST_COMMON.RESOURCE_Link_Btn_CheckBox];
         this.FMC_UnSelect = this.FBtn_CheckBox[CONST_COMMON.RESOURCE_Link_MC_UnSelect];
         TGameUtil.setButtonMode(this.FMC_UnSelect,true);
         this.FMC_UnSelect.addEventListener(MouseEvent.CLICK,this.CheckBoxOnClick);
         this.FMC_Selected = this.FBtn_CheckBox[CONST_COMMON.RESOURCE_Link_MC_Selected];
         TGameUtil.setButtonMode(this.FMC_Selected,true);
         this.FMC_Selected.visible = false;
         this.FMC_Selected.addEventListener(MouseEvent.CLICK,this.CheckBoxOnClick);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(false);
      }
      
      protected function TabSkillOnSwitch(param1:Object) : void
      {
         this.FCurSkillTabIndex = param1 as int;
         this.FCurSkillTabHeChengIndex = 0;
         this.FHeChengShowCount = 1;
         this.SetFCurNeedHeChengDate();
      }
      
      protected function HeChengOnChange(param1:Object, param2:int) : void
      {
         this.FHeChengPageIndex = param2;
         this.FHeChengPageIndexCopy = 0;
         this.FHeChengPageIndexCopy += this.FHeChengPageIndex * TEN;
         this.FCurSkillTabIndex = 0;
         this.FCurSkillTabHeChengIndex = 0;
         this.FHeChengShowCount = 1;
         this.FUITabSkill.SwithTagManual(this.FCurSkillTabIndex);
         this.SetFCurNeedHeChengDate();
      }
      
      public function SetFCurNeedHeChengDate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:AwakenDateCELL = null;
         this.FCurPeiZhiDate = this.CurDateBins.GetDatebaseByIndex(this.FHeChengPageIndexCopy + this.FCurSkillTabIndex) as TAwakenSkillClassification;
         var _loc3_:TAwakenSkillConfig = null;
         this.updateState();
         this.UpdateTabs();
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            if(_loc1_ >= this.FCurPeiZhiDate.HeChengNeedGodsArr.length)
            {
               this.FMC_SkillName[_loc1_].visible = false;
            }
            else
            {
               _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AwakenSkillConfig,this.FCurPeiZhiDate.HeChengNeedGodsArr[_loc1_]) as TAwakenSkillConfig;
               this.FTAwakenSkillConfig[_loc1_] = _loc3_;
               _loc4_ = 0;
               _loc2_ = 0;
               while(_loc2_ < THREE)
               {
                  if(_loc2_ < _loc3_.SynthesisArr.length)
                  {
                     _loc6_ = new AwakenDateCELL();
                     _loc6_.SetValueById(_loc3_.SynthesisArr[_loc2_][0]);
                     _loc6_.Count = _loc3_.SynthesisArr[_loc2_][1];
                     if(_loc2_ == 0)
                     {
                        _loc4_ = this.FAwakenDatas.GetCountById(_loc6_.AwakenConfigDate.Identifier) / _loc6_.Count;
                     }
                     _loc5_ = this.FAwakenDatas.GetCountById(_loc6_.AwakenConfigDate.Identifier) / _loc6_.Count;
                     _loc4_ = Math.min(_loc5_,_loc4_);
                  }
                  _loc2_++;
               }
               if(_loc4_ > 0)
               {
                  this.FTF_SkillName[_loc1_].text = _loc3_.Name + "(" + _loc4_ + ")";
               }
               else
               {
                  this.FTF_SkillName[_loc1_].text = _loc3_.Name;
               }
               this.FTF_SkillName[_loc1_].textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc3_.Quality];
            }
            _loc1_++;
         }
         this.UpdateCurNeedHeCheng();
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TAwakenSkillClassification = null;
         var _loc6_:TAwakenConfig = null;
         _loc1_ = 0;
         while(_loc1_ < TEN)
         {
            _loc4_ = _loc1_ + this.FHeChengPageIndex * TEN;
            if(_loc4_ >= this.CurDateBins.Count)
            {
               this.FUITabSkill.SetTabHideByIndex(_loc1_);
            }
            else
            {
               _loc5_ = this.CurDateBins.GetDatebaseByIndex(_loc4_) as TAwakenSkillClassification;
               this.FUITabSkill.SetTabCaptionByIndex(_loc5_.Name,_loc1_,CONST_COMMON.QUALITYCOLOR_INDEX[_loc5_.Quality]);
               this.FUITabSkill.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function updateState() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            if(_loc1_ == this.FCurSkillTabHeChengIndex)
            {
               this.FMC_SkillName[_loc1_].gotoAndStop(2);
            }
            else
            {
               this.FMC_SkillName[_loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHeChengPage() : void
      {
         this.FHeChengPage.TotalQuantity = this.CurDateBins.Count;
         this.FHeChengPage.PageIndex = this.FHeChengPageIndex;
         this.FHeChengPage.Update();
      }
      
      protected function UpdateCurNeedHeCheng() : void
      {
         this.FCurNeedHeChengDate.SetValueById(this.FTAwakenSkillConfig[this.FCurSkillTabHeChengIndex].Identifier);
         this.UpdateHeChengView();
      }
      
      public function UpdateHeChengView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:AwakenDateCELL = null;
         var _loc5_:int = 0;
         this.FMainSlot.SetDate(this.FCurNeedHeChengDate);
         this.FMC_Slot_Name.text = this.FCurNeedHeChengDate.AwakenSkillDate.Name;
         this.FMC_Slot_Name.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[this.FCurNeedHeChengDate.AwakenSkillDate.Quality];
         this.FTF_SkillDec.text = TUtilityString.Format(STRING_AWAKEN.Str5,this.FCurNeedHeChengDate.AwakenSkillDate.Name,this.FCurNeedHeChengDate.AwakenSkillDate.Description);
         if(this.FCurNeedHeChengDate)
         {
            this.UpdateHeChengCount();
         }
         else
         {
            this.UpdateHeChengCount(true);
         }
         _loc2_ = this.FAwakenDatas.CommonCount;
         this.FAllNeed = 0;
         _loc3_ = 0;
         while(_loc3_ < THREE)
         {
            if(this.FCurNeedHeChengDate)
            {
               if(_loc3_ >= this.FCurNeedHeChengDate.AwakenSkillDate.SynthesisArr.length)
               {
                  this.FSlotVec[_loc3_].SetDate(null);
                  this.FSlotVec[_loc3_].SetLocked(true);
                  this.FTFSkillNameVec[_loc3_].text = "";
               }
               else
               {
                  _loc4_ = new AwakenDateCELL();
                  _loc4_.SetValueById(this.FCurNeedHeChengDate.AwakenSkillDate.SynthesisArr[_loc3_][0]);
                  _loc4_.Count = this.FCurNeedHeChengDate.AwakenSkillDate.SynthesisArr[_loc3_][1];
                  this.FSlotVec[_loc3_].SetDate(_loc4_);
                  _loc5_ = this.FAwakenDatas.GetCountById(_loc4_.AwakenConfigDate.Identifier) / _loc4_.Count;
                  if(_loc3_ == 0)
                  {
                     this.FMax = this.FAwakenDatas.GetCountById(_loc4_.AwakenConfigDate.Identifier) / _loc4_.Count;
                  }
                  this.FMax = Math.min(_loc5_,this.FMax);
                  if(this.FIsSelected && _loc4_.AwakenConfigDate.Type == 2)
                  {
                     _loc1_ = Math.max(0,_loc4_.Count * this.FHeChengShowCount - this.FAwakenDatas.GetCountById(_loc4_.AwakenConfigDate.Identifier));
                     if(_loc2_ > _loc1_)
                     {
                        this.FSlotVec[_loc3_].SetCountAddCommon(this.FAwakenDatas.GetCountById(_loc4_.AwakenConfigDate.Identifier),_loc1_,_loc4_.Count * this.FHeChengShowCount);
                        this.FSlotVec[_loc3_].SetCountColor(39168);
                        _loc2_ -= _loc1_;
                     }
                     else
                     {
                        this.FSlotVec[_loc3_].SetCountAddCommon(this.FAwakenDatas.GetCountById(_loc4_.AwakenConfigDate.Identifier),_loc2_,_loc4_.Count * this.FHeChengShowCount);
                        this.FSlotVec[_loc3_].SetCountColor(16711680);
                        _loc2_ = 0;
                     }
                     this.FAllNeed += _loc1_;
                  }
                  else
                  {
                     this.FSlotVec[_loc3_].SetCount(this.FAwakenDatas.GetCountById(_loc4_.AwakenConfigDate.Identifier),_loc4_.Count * this.FHeChengShowCount);
                     if(this.FAwakenDatas.GetCountById(_loc4_.AwakenConfigDate.Identifier) >= _loc4_.Count * this.FHeChengShowCount)
                     {
                        this.FSlotVec[_loc3_].SetCountColor(39168);
                     }
                     else
                     {
                        this.FSlotVec[_loc3_].SetCountColor(16711680);
                     }
                  }
                  this.FCanUse = _loc4_.AwakenConfigDate.Type == 2 ? true : false;
                  this.FTFSkillNameVec[_loc3_].text = _loc4_.AwakenConfigDate.Name;
                  this.FSlotVec[_loc3_].SetLocked(false);
               }
            }
            else
            {
               this.FSlotVec[_loc3_].SetDate(null);
               this.FSlotVec[_loc3_].SetLocked(true);
            }
            _loc3_++;
         }
         this.FTF_CommonCount.text = this.FAwakenDatas.CommonCount.toString();
         if(this.FCanUse)
         {
            this.ThisPanel["MC_CommonTip"].visible = true;
            this.FBtn_CheckBox.visible = true;
            if(this.FIsSelected)
            {
               this.FTF_CommonDesc.text = TUtilityString.Format(STRING_AWAKEN.STRING_COMMONCOUNT,this.FAllNeed);
            }
            else
            {
               this.FTF_CommonDesc.text = "";
            }
         }
         else
         {
            this.ThisPanel["MC_CommonTip"].visible = false;
            this.FBtn_CheckBox.visible = false;
            this.FTF_CommonDesc.text = "";
         }
      }
      
      public function OpenThisPanel() : void
      {
         this.FHeChengPageIndex = 0;
         this.FHeChengPageIndexCopy = 0;
         this.FCurSkillTabIndex = 0;
         this.FCurSkillTabHeChengIndex = 0;
         this.FHeChengShowCount = 0;
         this.FUITabSkill.SwithTagManual(this.FCurSkillTabIndex);
         this.SetFCurNeedHeChengDate();
         this.UpdateHeChengPage();
         if(this.FIsFirst)
         {
            this.FIsFirst = false;
            this.FUIWindowConfirmation.Load();
         }
      }
      
      protected function UpdateHeChengCount(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.FTF_Count.text = this.FHeChengShowCount.toString();
            this.FTF_Cost.text = TUtilityString.Format(STRING_AWAKEN.Str4,0);
         }
         else if(this.FCurNeedHeChengDate)
         {
            if(this.FHeChengShowCount <= 0)
            {
               this.FHeChengShowCount = 1;
            }
            this.FTF_Count.text = this.FHeChengShowCount.toString();
            this.FTF_Cost.text = TUtilityString.Format(STRING_AWAKEN.Str4,this.FCurNeedHeChengDate.AwakenSkillDate.SilverSynthesis * this.FHeChengShowCount);
            this.FCurNeedHeChengDate.Count = this.FHeChengShowCount;
            this.FMainSlot.SetCountDanGe(this.FCurNeedHeChengDate.Count);
         }
      }
      
      public function UpdateImage() : void
      {
         var _loc1_:int = 0;
         if(!this.FThisPanel.visible)
         {
            return;
         }
         if(!this.FCurNeedHeChengDate)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            this.FSlotVec[_loc1_].UpdateImage();
            _loc1_++;
         }
         this.FMainSlot.UpdateImage();
      }
      
      protected function HandleMcOver(param1:MouseEvent) : void
      {
         if(MovieClip(param1.currentTarget).currentFrame == 2)
         {
            return;
         }
         MovieClip(param1.currentTarget).gotoAndStop(3);
      }
      
      protected function HandleMcOut(param1:MouseEvent) : void
      {
         if(MovieClip(param1.currentTarget).currentFrame == 2)
         {
            return;
         }
         MovieClip(param1.currentTarget).gotoAndStop(1);
      }
      
      protected function HandleMcClick(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1));
         if(this.FCurSkillTabHeChengIndex == _loc3_)
         {
            return;
         }
         this.FCurSkillTabHeChengIndex = _loc3_;
         this.SetFCurNeedHeChengDate();
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_HeChengBtn:
               if(this.FCurNeedHeChengDate)
               {
                  if(this.FIsSelected && this.FAllNeed > 0)
                  {
                     this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_AWAKEN.STRING_COMMONCONFIRMATION,this.FAllNeed);
                     this.FUIWindowConfirmation.SetCheckBox(false);
                     this.FUIWindowConfirmation.Visible = true;
                  }
                  else
                  {
                     this.WindowConfirmationOnOK(null);
                  }
               }
               break;
            case this.FMC_ReduceBtn:
               --this.FHeChengShowCount;
               this.UpdateHeChengView();
               break;
            case this.FMC_addBtn:
               ++this.FHeChengShowCount;
               this.UpdateHeChengView();
               break;
            case this.FBTN_Max:
               this.FHeChengShowCount = this.FMax;
               this.UpdateHeChengView();
         }
      }
      
      protected function CheckBoxOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         this.FIsSelected = !this.FIsSelected;
         if(this.FIsSelected)
         {
            this.FMC_Selected.visible = true;
         }
         else
         {
            this.FMC_Selected.visible = false;
         }
         this.UpdateHeChengView();
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         if(this.FCurNeedHeChengDate)
         {
            if(this.FBtnClickBack != null)
            {
               this.FBtnClickBack(0,this.FCurNeedHeChengDate.AwakenConfigDate.Identifier,this.FHeChengShowCount,this.FCurNeedHeChengDate.AwakenConfigDate.Name,this.FHeChengShowCount,this.FIsSelected ? 1 : 0);
            }
         }
      }
      
      protected function HandleInPut(param1:Event) : void
      {
         if(!this.FCurNeedHeChengDate)
         {
            return;
         }
         this.FHeChengShowCount = int(this.FTF_Count.text);
         this.UpdateHeChengView();
      }
      
      public function set BtnClickBack(param1:Function) : void
      {
         this.FBtnClickBack = param1;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function set BackOver(param1:Function) : void
      {
         this.FBackOver = param1;
      }
      
      public function set BackOut(param1:Function) : void
      {
         this.FBackOut = param1;
      }
      
      public function set BackMove(param1:Function) : void
      {
         this.FBackMove = param1;
      }
   }
}

