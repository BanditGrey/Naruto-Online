package Processors.Game.Lobby.Organization.TreasureTree
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityCartisian;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Organization.TreasureTree.TBasicTreasureTree;
   import Logics.Organization.TreasureTree.TOperatingShowInfo;
   import Logics.Organization.TreasureTree.TOperatingShowInfos;
   import Logics.Organization.TreasureTree.TUserFruitInfo;
   import Logics.Organization.TreasureTree.TUserFruitInfos;
   import Logics.Organization.TreasureTree.TUserWaterInfo;
   import Logics.Organization.TreasureTree.TUserWaterInfos;
   import Logics.SLogicsCore;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_ORGANIZATION;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUITreasureTree extends TUIComponent
   {
      
      protected var FMainUI:MovieClip;
      
      protected var FMC_ChangeListPage:Sprite;
      
      protected var FTF_PickTimes:TextField;
      
      protected var FTF_WaterTimes:TextField;
      
      protected var FMC_PushChakra:MovieClip;
      
      protected var FTF_PushChakraTimes:TextField;
      
      protected var FBTN_AddChakraTimes:SimpleButton;
      
      protected var FTF_Experience:TextField;
      
      protected var FMC_ProgressBarExp:MovieClip;
      
      protected var FTF_TreeLevel:TextField;
      
      protected var FMC_List:MovieClip;
      
      protected var FMC_PushChakaraCDTime:Sprite;
      
      protected var FTF_CDTime:TextField;
      
      protected var FBTN_Fast:SimpleButton;
      
      protected var FMC_OneKeyWaters:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FUIFruitTip:TUIFruitTip;
      
      protected var FUIFruits:Vector.<TUIFruit>;
      
      protected var FUIOrgMembers:Vector.<TUIOrgMember>;
      
      protected var FIsInitialization:Boolean;
      
      protected var FUserFruitInfos:TUserFruitInfos;
      
      protected var FUserWaterInfos:TUserWaterInfos;
      
      protected var FBasicTreasureTree:TBasicTreasureTree;
      
      protected var FBounds:TBounds;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FWIindowInfomationType:uint;
      
      protected var FType:uint;
      
      protected var FAddCountVec:Vector.<uint>;
      
      protected var FLogInfoTextFieldList:Vector.<TextField>;
      
      protected var FCheckBoxIsSelects:Vector.<Boolean>;
      
      protected var FPushChakraOnClick:Function;
      
      protected var FAddChakraTimesOnClick:Function;
      
      protected var FFastOnClick:Function;
      
      protected var FUserFruitFastMature:Function;
      
      protected var FWaterOrgMemberOnClick:Function;
      
      protected var FPickFruitOnClick:Function;
      
      protected var FOnEffectText:Function;
      
      protected var FKeyWatersClisk:Function;
      
      public function TUITreasureTree(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FUIFruits = new Vector.<TUIFruit>(CONST_ORGANIZATION.CAPACITY_FRUITS);
         this.FUIOrgMembers = new Vector.<TUIOrgMember>(CONST_ORGANIZATION.CAPACITY_ORGMEMBERS);
         this.FUIPage = new TUIPage(this);
         this.FBounds = new TBounds();
         this.FCheckBoxIsSelects = new Vector.<Boolean>();
         this.FUserFruitInfos = SLogicsCore.Organization.BasicTreasureTree.UserFruitInfos;
         this.FUserWaterInfos = SLogicsCore.Organization.BasicTreasureTree.UserWaterInfos;
         this.FBasicTreasureTree = SLogicsCore.Organization.BasicTreasureTree;
         this.FLogInfoTextFieldList = new Vector.<TextField>();
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIFruit = null;
         var _loc4_:TUIOrgMember = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         addChild(this.FMainUI);
         this.FTF_TreeLevel = this.FMainUI["MC_Experience"]["TF_TreeLevel"];
         this.FTF_Experience = this.FMainUI["MC_Experience"]["TF_Experience"];
         this.FMC_ProgressBarExp = this.FMainUI["MC_Experience"]["MC_ProgressBarExp"];
         this.FTF_PickTimes = this.FMainUI["TF_PickTimes"];
         this.FTF_WaterTimes = this.FMainUI["TF_WaterTimes"];
         this.FMC_PushChakra = this.FMainUI["MC_PushChakra"];
         TGameUtil.setButtonMode(this.FMC_PushChakra,true);
         this.FTF_PushChakraTimes = this.FMainUI["TF_PushChakraTimes"];
         this.FBTN_AddChakraTimes = this.FMainUI["BTN_AddChakraTimes"];
         this.FMC_PushChakaraCDTime = this.FMainUI["MC_PushChakaraCDTime"];
         this.FTF_CDTime = this.FMC_PushChakaraCDTime["TF_CDTime"];
         this.FBTN_Fast = this.FMC_PushChakaraCDTime["BTN_Fast"];
         this.FMC_PushChakaraCDTime.visible = false;
         _loc2_ = 4;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FCheckBoxIsSelects.push(false);
            _loc1_++;
         }
         _loc2_ = CONST_ORGANIZATION.CAPACITY_FRUITS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIFruit(this);
            _loc3_.Resource = this.FMainUI["MC_Fruit_" + _loc1_];
            _loc3_.Tag = _loc1_;
            _loc3_.FruitOnOver = this.ProcessorFruitOnOver;
            _loc3_.FruitOnOut = this.ProcessorFruitOnOut;
            _loc3_.FruitOnClick = this.ProcessorFruitOnClick;
            _loc3_.Init();
            this.FUIFruits[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc2_ = CONST_ORGANIZATION.CAPACITY_ORGMEMBERS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUIOrgMember(this);
            _loc4_.Resource = this.FMainUI["MC_OrgMember_" + _loc1_];
            _loc4_.WaterOnClick = this.ProcessorWaterOnClick;
            _loc4_.Init();
            this.FUIOrgMembers[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FUIFruitTip = new TUIFruitTip(this);
         this.FUIFruitTip.Resource = this.FMainUI["MC_FruitStatusTip"];
         this.FUIFruitTip.FastGrowUpOnClick = this.ProcessorFastGrowUpOnClick;
         this.FUIFruitTip.Init();
         this.FUIFruitTip.Visible = false;
         this.FMC_ChangeListPage = this.FMainUI["MC_ChangeListPage"];
         _loc5_ = this.FMC_ChangeListPage["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = this.FMC_ChangeListPage["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         _loc6_ = this.FMC_ChangeListPage["TF_Page"];
         this.FUIPage.LabelPage = _loc6_;
         this.FUIPage.PageSize = CONST_ORGANIZATION.CAPACITY_ORGMEMBERS;
         this.FUIPage.Init();
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent.Parent.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.OnCancel = this.WindowInformationOnCancel;
         this.FUIWindowInformation.OnCheckBoxSelected = this.WindowInformationOnSelect;
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowInformation.SetCheckBox(true);
         this.FScrollBar = new TScrollBar(this.FMainUI["mc_list"],141,false,2);
         this.FMC_OneKeyWaters = this.FMainUI["MC_OneKeyWaters"];
         TGameUtil.setButtonMode(this.FMC_OneKeyWaters,true);
      }
      
      protected function Resources_Locations() : void
      {
         var _loc1_:TConfigValue = null;
         this.FBTN_Fast.addEventListener(MouseEvent.CLICK,this.BTNFastOnClick,false,0,true);
         this.FMC_PushChakra.addEventListener(MouseEvent.CLICK,this.MCPushChakraOnClick,false,0,true);
         this.FBTN_AddChakraTimes.addEventListener(MouseEvent.CLICK,this.BTNAddChakraTimesOnClick,false,0,true);
         this.FUIFruitTip.addEventListener(MouseEvent.ROLL_OVER,this.UIFruitTipOnOver,false,0,true);
         this.FUIFruitTip.addEventListener(MouseEvent.ROLL_OUT,this.UIFruitTipOnOut,false,0,true);
         this.FMC_OneKeyWaters.addEventListener(MouseEvent.CLICK,this.OneKeyWatersClisk);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BUY_PRICE) as TConfigValue;
         this.FAddCountVec = _loc1_.Value as Vector.<uint>;
         this.FUIPage.OnChangePage = this.PageOnChange;
      }
      
      protected function UpdateOtherInfos() : void
      {
         var _loc1_:int = 0;
         this.FTF_PickTimes.text = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_RestPickCount,this.FBasicTreasureTree.UserFruitPickCount);
         this.FTF_WaterTimes.text = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_RestWaterCount,this.FBasicTreasureTree.UserWaterCount);
         this.FTF_PushChakraTimes.text = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_RestPushChakara,this.FBasicTreasureTree.PushChakaraCount);
         _loc1_ = this.FBasicTreasureTree.PushChakaraCDTime - STimingCore.GetServerTick();
         this.FMC_PushChakaraCDTime.visible = _loc1_ >= 0;
         this.FMC_PushChakra.visible = !this.FMC_PushChakaraCDTime.visible;
      }
      
      protected function UpdateUIFruits() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIFruit = null;
         var _loc4_:TUserFruitInfo = null;
         _loc2_ = CONST_ORGANIZATION.CAPACITY_FRUITS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIFruits[_loc1_];
            _loc4_ = this.FUserFruitInfos.GetUserFruitByIndex(_loc1_);
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateUIOrgMembers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIOrgMember = null;
         var _loc4_:TUserWaterInfo = null;
         var _loc5_:int = 0;
         _loc2_ = CONST_ORGANIZATION.CAPACITY_ORGMEMBERS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIOrgMembers[_loc1_];
            _loc5_ = _loc1_ + _loc2_ * this.FPageIndex;
            _loc4_ = this.FUserWaterInfos.GetUserWaterByIndex(_loc5_);
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateExperience() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = this.FBasicTreasureTree.TreeCurrentExp;
         _loc2_ = this.FBasicTreasureTree.TreeLevelupExp;
         this.FTF_TreeLevel.text = this.FBasicTreasureTree.TreeLevel.toString();
         if(_loc2_ == 0)
         {
            this.FMC_ProgressBarExp.width = 0;
         }
         else
         {
            this.FMC_ProgressBarExp.width = _loc1_ / _loc2_ * CONST_ORGANIZATION.WIDTH_ExpBar;
         }
         this.FTF_Experience.text = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_TreeExp,_loc1_,_loc2_);
      }
      
      protected function UpdateTextInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TextField = null;
         var _loc4_:String = null;
         var _loc5_:TOperatingShowInfo = null;
         var _loc6_:TOperatingShowInfos = null;
         var _loc7_:int = 0;
         _loc6_ = this.FBasicTreasureTree.OperatingShowInfos;
         _loc2_ = uint(this.FScrollBar.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FLogInfoTextFieldList.push(this.FScrollBar.Items[_loc1_]);
            _loc1_++;
         }
         this.FScrollBar.Clear();
         _loc2_ = _loc6_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FLogInfoTextFieldList.length > 0)
            {
               _loc3_ = this.FLogInfoTextFieldList.pop();
            }
            else
            {
               _loc3_ = new TextField();
               _loc3_.selectable = false;
               _loc3_.wordWrap = true;
               _loc3_.width = 145;
            }
            _loc7_ = _loc2_ - 1 - _loc1_;
            _loc5_ = _loc6_.GetShowInfoByIndex(_loc7_);
            if(_loc5_ != null)
            {
               _loc4_ = this.MakeHtmlTextStr(_loc5_);
               _loc3_.htmlText = _loc4_;
               _loc3_.height = _loc3_.textHeight + 5;
               this.FScrollBar.AddItem(_loc3_,false);
            }
            _loc1_++;
         }
         this.FScrollBar.ScrollToUp();
      }
      
      protected function MakeHtmlTextStr(param1:TOperatingShowInfo) : String
      {
         var _loc2_:String = null;
         _loc2_ = "";
         switch(param1.ShowType)
         {
            case CONST_ORGANIZATION.ShowType_AddExp:
               _loc2_ = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_PushChakara,CONST_COMMON.QUALITYCOLOR_INDEX[param1.UserQuality],param1.UserName,param1.AddExp);
               break;
            case CONST_ORGANIZATION.ShowType_TreeLevelup:
               _loc2_ = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_TreeLevel,param1.CurrentTreeLevel);
               break;
            case CONST_ORGANIZATION.ShowType_FruitMature:
               _loc2_ = STRING_ORGANIZATION.String_OrgFruitMature;
               break;
            case CONST_ORGANIZATION.ShowType_OrgFruitPick:
               _loc2_ = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_OrgPick,CONST_COMMON.QUALITYCOLOR_INDEX[param1.UserQuality],param1.UserName,param1.RewardName,param1.RewardCount);
               break;
            case CONST_ORGANIZATION.ShowType_UserFruitPick:
               _loc2_ = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_UserPick,CONST_COMMON.QUALITYCOLOR_INDEX[param1.UserQuality],param1.UserName,param1.FruitName,param1.RewardName,param1.RewardCount);
         }
         return _loc2_;
      }
      
      protected function UpdateTreeUI() : void
      {
         this.UpdateUIFruits();
         this.UpdateUIOrgMembers();
         this.UpdateTextInfo();
         this.UpdateOtherInfos();
         this.UpdateExperience();
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FUIPage.TotalQuantity = this.FUserWaterInfos.Count;
         if(this.FUIPage.TotalQuantity == CONST_ORGANIZATION.CAPACITY_ORGMEMBERS)
         {
            this.FPageIndex = 0;
         }
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UIFruitTipOnOver(param1:MouseEvent) : void
      {
         this.FUIFruitTip.Visible = true;
      }
      
      protected function UIFruitTipOnOut(param1:MouseEvent) : void
      {
         this.FUIFruitTip.Visible = false;
      }
      
      protected function ProcessorFastGrowUpOnClick(param1:Object, param2:Object, param3:Boolean) : void
      {
         var _loc4_:TUserFruitInfo = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc4_ = param2 as TUserFruitInfo;
         this.FType = uint(param3);
         if(param3)
         {
            _loc6_ = STRING_ORGANIZATION.FORMAT_EvolveCost;
            _loc5_ = Math.ceil((_loc4_.FruitEvolveTime - STimingCore.GetServerTick()) / 60) * 1;
            this.FWIindowInfomationType = CONST_ORGANIZATION.TYPE_WindowConfirmationEvolve;
         }
         else
         {
            _loc6_ = STRING_ORGANIZATION.FORMAT_MatureCost;
            _loc5_ = Math.ceil((_loc4_.FruitMatureTime - STimingCore.GetServerTick()) / 60) * 1;
            this.FWIindowInfomationType = CONST_ORGANIZATION.TYPE_WindowConfirmationMature;
         }
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         if(this.FCheckBoxIsSelects[this.FWIindowInfomationType])
         {
            this.WindowInformationOnOK(null);
            return;
         }
         this.FUIWindowInformation.IsSelected = false;
         this.FUIWindowInformation.SetSelectedOrNot(false);
         this.FUIWindowInformation.Text = TUtilityString.Format(_loc6_,_loc5_);
         this.FUIWindowInformation.Visible = true;
      }
      
      protected function BTNFastOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = this.FBasicTreasureTree.PushChakaraCDTime - STimingCore.GetServerTick();
         _loc2_ = Math.ceil(_loc3_ / 60) * 1;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this.FWIindowInfomationType = CONST_ORGANIZATION.TYPE_WindowConfirmationChakara;
         if(this.FCheckBoxIsSelects[this.FWIindowInfomationType])
         {
            this.WindowInformationOnOK(null);
            return;
         }
         this.FUIWindowInformation.IsSelected = false;
         this.FUIWindowInformation.SetSelectedOrNot(false);
         this.FUIWindowInformation.Text = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_ChakaraCost,_loc2_);
         this.FUIWindowInformation.Visible = true;
      }
      
      protected function MCPushChakraOnClick(param1:MouseEvent) : void
      {
         if(this.FPushChakraOnClick != null)
         {
            this.FPushChakraOnClick(this);
         }
      }
      
      protected function BTNAddChakraTimesOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         _loc3_ = this.FAddCountVec.length - this.FBasicTreasureTree.AddPushChakaraRestCount;
         if(this.FBasicTreasureTree.AddPushChakaraRestCount == 0)
         {
            this.FOnEffectText(STRING_ORGANIZATION.STRING_PushChakaraCountUseless);
            return;
         }
         this.FWIindowInfomationType = CONST_ORGANIZATION.TYPE_WindowConfirmationAddChakaraCount;
         if(this.FCheckBoxIsSelects[this.FWIindowInfomationType])
         {
            this.WindowInformationOnOK(null);
            return;
         }
         this.FUIWindowInformation.IsSelected = false;
         this.FUIWindowInformation.SetSelectedOrNot(false);
         _loc2_ = this.FAddCountVec[_loc3_];
         this.FUIWindowInformation.Text = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_AddChakaraCountCost,_loc2_);
         this.FUIWindowInformation.Visible = true;
      }
      
      protected function MCListOnRollOver(param1:MouseEvent) : void
      {
      }
      
      protected function MCListOnRollOut(param1:MouseEvent) : void
      {
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateUIOrgMembers();
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         switch(this.FWIindowInfomationType)
         {
            case CONST_ORGANIZATION.TYPE_WindowConfirmationMature:
            case CONST_ORGANIZATION.TYPE_WindowConfirmationEvolve:
               if(this.FUserFruitFastMature != null)
               {
                  this.FUserFruitFastMature(this,this.FUIFruitTip.Tag,this.FType);
               }
               break;
            case CONST_ORGANIZATION.TYPE_WindowConfirmationAddChakaraCount:
               if(this.FAddChakraTimesOnClick != null)
               {
                  this.FAddChakraTimesOnClick(this);
               }
               break;
            case CONST_ORGANIZATION.TYPE_WindowConfirmationChakara:
               if(this.FFastOnClick != null)
               {
                  this.FFastOnClick(this);
               }
         }
      }
      
      protected function WindowInformationOnCancel(param1:Object) : void
      {
         this.FCheckBoxIsSelects[this.FWIindowInfomationType] = false;
      }
      
      protected function WindowInformationOnSelect(param1:Object, param2:Boolean) : void
      {
         this.FCheckBoxIsSelects[this.FWIindowInfomationType] = param2;
      }
      
      protected function ProcessorFruitOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TUIFruit = null;
         var _loc4_:uint = 0;
         _loc3_ = param1 as TUIFruit;
         _loc4_ = uint(_loc3_.Tag);
         this.FUIFruitTip.Visible = true;
         this.FUIFruitTip.Tag = _loc4_;
         if(_loc4_ > 3)
         {
            this.FUIFruitTip.X = 300;
            this.FUIFruitTip.Y = 90;
         }
         else
         {
            this.FUIFruitTip.X = _loc3_.Resource.x + _loc3_.Resource.width + 170;
            this.FUIFruitTip.Y = _loc3_.Resource.y + _loc3_.Resource.height - 35;
         }
         this.FUIFruitTip.Context = param2;
         this.FUIFruitTip.Update();
      }
      
      protected function ProcessorFruitOnOut(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:TCoordinate = null;
         _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(this.FUIFruitTip);
         this.FBounds.Assign(_loc3_);
         this.FBounds.Width = this.FUIFruitTip.Width;
         this.FBounds.Height = this.FUIFruitTip.Height + 10;
         this.FBounds.Y -= 10;
         _loc2_ = TUtilityCartisian.BoundsContainsCoordinate(this.FBounds,FUICore.MouseCoordinate);
         if(!_loc2_)
         {
            this.FUIFruitTip.Visible = false;
         }
      }
      
      protected function ProcessorFruitOnClick(param1:Object, param2:Object) : void
      {
         if(this.FPickFruitOnClick != null)
         {
            this.FPickFruitOnClick(this,(param1 as TUIFruit).Tag);
         }
      }
      
      protected function ProcessorWaterOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TUserWaterInfo = null;
         _loc3_ = param2 as TUserWaterInfo;
         if(_loc3_ == null)
         {
            return;
         }
         if(this.FWaterOrgMemberOnClick != null)
         {
            this.FWaterOrgMemberOnClick(this,_loc3_.OrgMemberID0,_loc3_.OrgMemberID1);
         }
      }
      
      protected function OneKeyWatersClisk(param1:MouseEvent) : void
      {
         if(this.FKeyWatersClisk != null)
         {
            this.FKeyWatersClisk();
         }
      }
      
      public function set PushChakraOnClick(param1:Function) : void
      {
         this.FPushChakraOnClick = param1;
      }
      
      public function set AddChakraTimesOnClick(param1:Function) : void
      {
         this.FAddChakraTimesOnClick = param1;
      }
      
      public function set UserFruitFastMature(param1:Function) : void
      {
         this.FUserFruitFastMature = param1;
      }
      
      public function set FastOnClick(param1:Function) : void
      {
         this.FFastOnClick = param1;
      }
      
      public function set WaterOrgMemberOnClick(param1:Function) : void
      {
         this.FWaterOrgMemberOnClick = param1;
      }
      
      public function set PickFruitOnClick(param1:Function) : void
      {
         this.FPickFruitOnClick = param1;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function set KeyWatersClisk(param1:Function) : void
      {
         this.FKeyWatersClisk = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.FMainUI = param1;
         this.Resources_UIDispatch();
         this.Resources_Locations();
         this.FIsInitialization = true;
      }
      
      public function Update() : void
      {
         this.UpdatePageInfo();
         this.UpdateTreeUI();
         this.ProcessorFruitOnOut(null);
         this.UIFruitTipOnOut(null);
      }
      
      public function Reset() : void
      {
         this.FPageIndex = 0;
         this.ProcessorFruitOnOut(null);
         this.UIFruitTipOnOut(null);
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIOrgMember = null;
         var _loc4_:int = 0;
         if(!this.FIsInitialization)
         {
            return;
         }
         _loc2_ = CONST_ORGANIZATION.CAPACITY_ORGMEMBERS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIOrgMembers[_loc1_];
            _loc3_.UpdateCDTime();
            _loc1_++;
         }
         this.FUIFruitTip.UpdateCDTime();
         _loc4_ = this.FBasicTreasureTree.PushChakaraCDTime - STimingCore.GetServerTick();
         this.FMC_PushChakra.visible = Boolean(_loc4_ <= 0);
         this.FMC_PushChakaraCDTime.visible = !this.FMC_PushChakra.visible;
         this.FTF_CDTime.text = TGameUtil.fomatTime(_loc4_);
      }
   }
}

