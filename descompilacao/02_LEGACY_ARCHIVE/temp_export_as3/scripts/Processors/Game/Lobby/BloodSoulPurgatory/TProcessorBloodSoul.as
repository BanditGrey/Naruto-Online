package Processors.Game.Lobby.BloodSoulPurgatory
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TBloodSoul_Attr;
   import Logics.DatebaseVO.VO.TBloodSoul_battle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Resources.Constants.CONST_BLOODPURGATORY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorBloodSoul extends TProcessorLobbyWindow
   {
      
      public static const InventoryItemId:Vector.<uint> = Vector.<uint>([14107073,14107072,14107074,14112005]);
      
      public static var NUM_TAB:int = 4;
      
      protected var FMcPanel:Sprite;
      
      protected var FBloodSoulCloseBtnFun:Function;
      
      protected var FPositionArr:Array;
      
      protected var FBloodSoulVec:Vector.<MovieClip>;
      
      protected var FBloodSoulBarVec:Vector.<BloodSoulUint>;
      
      protected var FPopFrameMc:MovieClip;
      
      protected var FAlonePopFrame:AlonePopFrame;
      
      protected var FShut:int;
      
      protected var FLayer:int;
      
      protected var Funit:int;
      
      protected var FcustomId:int;
      
      protected var FStuffIdArr:Vector.<Object>;
      
      protected var FThreeArr:Vector.<DataStructureForBloodSoul>;
      
      protected var FFMore_High:int;
      
      protected var FSelectInventories:TInventories = null;
      
      protected var FAtWhere:int;
      
      protected var FAtBeforeWhere:int = 7;
      
      protected var FAloneWhere:int = 0;
      
      protected var FisInitili:Boolean = true;
      
      protected var FPrice:int;
      
      protected var TArt:TArticle = null;
      
      protected var FAlonePopBackFunc:Function;
      
      protected var FBtnOverBackFunc:Function;
      
      protected var FBtnMoveBackFunc:Function;
      
      protected var FBtnOutBackFunc:Function;
      
      protected var FDistant:Function;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowNotify:TUIWindowInformation;
      
      protected var FSelectType:uint;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FGoldPuergatoryArr:Vector.<uint>;
      
      protected var FBloodSoulCount:uint;
      
      protected var FBeforHasItem:Boolean;
      
      protected var FSelectInventoryCount:uint;
      
      protected var FCurInventoryCount:uint;
      
      protected var silverTimes:int;
      
      protected var FGoToBloodPurgatoryPanel:Function;
      
      public function TProcessorBloodSoul(param1:TUIComponent)
      {
         super(param1);
         this.FPositionArr = new Array();
         this.FBloodSoulVec = new Vector.<MovieClip>(NUM_TAB);
         this.FBloodSoulBarVec = new Vector.<BloodSoulUint>();
         this.FAlonePopFrame = new AlonePopFrame();
         this.FAlonePopFrame.BtnBackFunc = this.FAlonePopFrameF;
         this.FAlonePopFrame.BtnOverBackFunc = this.FBtnOverBackFuncF;
         this.FAlonePopFrame.BtnMoveBackFunc = this.FBtnMoveBackFuncF;
         this.FAlonePopFrame.BtnOutBackFunc = this.FBtnOutBackFuncF;
         this.FAlonePopFrame.RootOutBackFunc = this.RootOutBackFuncF;
         this.FThreeArr = new Vector.<DataStructureForBloodSoul>();
         this.FSelectInventories = SLogicsCore.Character.Appliances;
      }
      
      public function setRootPanel(param1:Sprite) : void
      {
         var _loc3_:TConfigValue = null;
         var _loc4_:BloodSoulUint = null;
         var _loc5_:Boolean = false;
         this.FMcPanel = param1;
         var _loc2_:int = 0;
         SimpleButton(this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_CloseBtn]).addEventListener(MouseEvent.CLICK,this.BloodSoulCloseBtn);
         this.FPopFrameMc = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_Alone_Tool];
         this.FAlonePopFrame.setRootPanel(this.FPopFrameMc[CONST_BLOODPURGATORY.BooldPurgatory_MC_Pop_Frame]);
         if(!SLogicsCore.Character.GetConfigValueById(91000011))
         {
            _loc5_ = true;
         }
         var _loc6_:Array = new Array(77,273,465,0);
         _loc2_ = 0;
         while(_loc2_ < NUM_TAB)
         {
            this.FBloodSoulVec[_loc2_] = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_MCTab_ + _loc2_];
            if(_loc5_)
            {
               if(_loc2_ == 3)
               {
                  this.FBloodSoulVec[_loc2_].visible = false;
               }
               this.FBloodSoulVec[_loc2_].x = _loc6_[_loc2_];
            }
            _loc4_ = new BloodSoulUint(this.FBloodSoulVec[_loc2_],_loc2_);
            this.FBloodSoulBarVec.push(_loc4_);
            this.FBloodSoulBarVec[_loc2_].StuffId = this.FStuffIdArr[_loc2_][1];
            this.FPositionArr.push({
               "XX":this.FBloodSoulBarVec[_loc2_].BloodSoulPanel.x + 103,
               "YY":this.FBloodSoulBarVec[_loc2_].BloodSoulPanel.y + 63
            });
            this.FBloodSoulBarVec[_loc2_].BloodSoulPanel.addEventListener(MouseEvent.MOUSE_OVER,this.CustomsTabOVER);
            this.FBloodSoulBarVec[_loc2_].BloodSoulPanel.addEventListener(MouseEvent.MOUSE_OUT,this.CustomsTabOUT);
            this.FBloodSoulBarVec[_loc2_].BloodSoulPanel.mouseChildren = false;
            _loc2_++;
         }
         new Tools_Help(FParent,this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_HelpBtn],CONST_SYSTEMLANGUAGE.HELPTIPS_BloodSoulPurgatory__Laboratory,FUICore);
         this.FPopFrameMc.addEventListener(MouseEvent.MOUSE_OVER,this.FPopFrameOver);
         this.FPopFrameMc.addEventListener(MouseEvent.MOUSE_OUT,this.PFPopFrameOut);
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowInformation.SetCheckBox(true);
         this.FUIWindowNotify = new TUIWindowInformation(this.Parent);
         this.FUIWindowNotify.x = (CONST_COMMON.STAGE_Width - this.FUIWindowNotify.WindowWidth) / 2;
         this.FUIWindowNotify.y = (CONST_COMMON.STAGE_Height - this.FUIWindowNotify.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowNotify);
         this.FUIWindowNotify.Visible = false;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BloodSoulCount) as TConfigValue;
         this.FBloodSoulCount = _loc3_.Value as int;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_GOLD_PRICE) as TConfigValue;
         this.FGoldPuergatoryArr = _loc3_.Value as Vector.<uint>;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(false);
         this.TArt = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,14107119) as TArticle;
      }
      
      public function FPopFrameOver(param1:MouseEvent) : void
      {
         this.FAloneWhere = 1;
      }
      
      public function PFPopFrameOut(param1:MouseEvent) : void
      {
         this.FAloneWhere = 0;
      }
      
      public function CustomsTabOVER(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         this.FAtWhere = int(_loc2_.charAt(_loc2_.length - 1));
         if(this.FThreeArr.length == 0)
         {
            return;
         }
         if(this.FAtBeforeWhere != this.FAtWhere)
         {
            this.UpdatePosition();
            this.FAlonePopFrame.BooldType = this.FAtWhere;
            this.FAlonePopFrameUpdate(this.FAtWhere);
            this.FPrice = this.getPrice(this.FThreeArr[this.FAtWhere].SoulId);
         }
      }
      
      public function FAlonePopFrameUpdate(param1:int) : void
      {
         if(this.FBloodSoulBarVec[param1].IsOpen)
         {
            this.FAlonePopFrame.IsCanUse = true;
            this.FAlonePopFrame.SetFilters(false);
            this.FAlonePopFrame.Reason01 = false;
         }
         else
         {
            this.FAlonePopFrame.IsCanUse = false;
            this.FAlonePopFrame.SetFilters(true);
            this.FAlonePopFrame.Reason01 = true;
         }
         this.FAtBeforeWhere = param1;
         this.FAlonePopFrame.StuffShow = this.FBloodSoulBarVec[param1].StuffId;
         this.FAlonePopFrame.UpdataStuffCount();
         if(!this.FThreeArr.length)
         {
            return;
         }
         this.FAlonePopFrame.SourId = this.FThreeArr[param1].SoulId;
         this.FAlonePopFrame.GoldTimes = this.FThreeArr[param1].goldTimes;
      }
      
      public function CustomsTabOUT(param1:MouseEvent) : void
      {
      }
      
      public function RootOutBackFuncF() : void
      {
         this.FBtnOutBackFunc(0,0);
      }
      
      public function UpdatePosition() : void
      {
         this.FPopFrameMc.visible = false;
         this.FPopFrameMc.x = this.FPositionArr[this.FAtWhere].XX;
         this.FPopFrameMc.y = this.FPositionArr[this.FAtWhere].YY;
         this.FPopFrameMc.visible = true;
         this.FBtnOutBackFunc(0,0);
         this.FPopFrameMc.gotoAndPlay(1);
      }
      
      public function BloodSoulPurgatory_Initili_Ret(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:DataStructureForBloodSoul = null;
         var _loc3_:int = param1.readShort();
         this.FThreeArr.length = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = int(param1.readUnsignedInt());
            _loc5_ = new DataStructureForBloodSoul();
            _loc5_.SoulId = _loc4_;
            _loc5_.CurExp = param1.readUnsignedInt();
            _loc5_.goldTimes = param1.readUnsignedInt();
            _loc5_.type = this.getCustomType(_loc4_);
            this.FThreeArr.push(_loc5_);
            _loc2_++;
         }
         this.silverTimes = param1.readUnsignedInt();
         if(_loc4_ != 0)
         {
            if(this.FDistant != null)
            {
               this.FDistant(this.FThreeArr);
            }
         }
         if(this.FBloodSoulBarVec.length == 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FBloodSoulBarVec[_loc2_].initili(this.FThreeArr[_loc2_]);
            _loc2_++;
         }
         this.GetCustomLayerCopy();
         if(this.FAtBeforeWhere != 7)
         {
            this.FAlonePopFrameUpdate(this.FAtBeforeWhere);
         }
         this.SetSilverCount();
      }
      
      public function FreeSilverCount(param1:int) : void
      {
         this.FAlonePopFrame.FreeSilverCount = param1;
      }
      
      public function FStuffIdArrF(param1:Vector.<Object>) : void
      {
         this.FStuffIdArr = param1;
      }
      
      public function FMore_High(param1:int) : void
      {
         this.FFMore_High = param1;
      }
      
      public function BloodSoulPurgatory_Practice_Ret(param1:ByteArray) : void
      {
         var _loc10_:BloodSoulUint = null;
         var _loc11_:DataStructureForBloodSoul = null;
         var _loc13_:String = null;
         var _loc2_:int = int(param1.readUnsignedInt());
         var _loc3_:int = int(param1.readUnsignedInt());
         var _loc4_:int = int(param1.readUnsignedInt());
         var _loc5_:int = int(param1.readUnsignedInt());
         var _loc6_:int = int(param1.readUnsignedInt());
         var _loc7_:int = int(param1.readUnsignedInt());
         var _loc8_:int = int(param1.readUnsignedInt());
         var _loc9_:int = int(param1.readUnsignedInt());
         _loc10_ = this.FBloodSoulBarVec[_loc5_];
         _loc11_ = this.FThreeArr[_loc5_];
         _loc11_.SoulId = _loc6_;
         _loc11_.CurExp = _loc8_;
         var _loc12_:int = _loc11_.goldTimes;
         if(_loc2_ == 1)
         {
            ++this.silverTimes;
         }
         else if(_loc2_ == 2)
         {
            _loc12_++;
         }
         else
         {
            _loc12_ += _loc9_;
         }
         _loc11_.goldTimes = _loc12_;
         _loc10_.initili(_loc11_);
         this.GetCustomLayerLittle();
         this.FAlonePopFrameUpdate(this.FAtBeforeWhere);
         this.SetSilverCount();
         if(_loc3_ > 0 && _loc4_ > 0)
         {
            _loc13_ = TUtilityString.Format(STRING_TONGLING.TONGLING_25,_loc9_,_loc3_,_loc4_,_loc7_);
         }
         else if(_loc3_ > 0)
         {
            _loc13_ = TUtilityString.Format(STRING_TONGLING.TONGLING_27,_loc9_,_loc3_,_loc7_);
         }
         else if(_loc4_ > 0)
         {
            _loc13_ = TUtilityString.Format(STRING_TONGLING.TONGLING_28,_loc9_,_loc4_,_loc7_);
         }
         else
         {
            _loc13_ = TUtilityString.Format(STRING_TONGLING.TONGLING_26,_loc7_);
         }
         EffectGenerateText(_loc13_);
         if(this.FDistant != null)
         {
            this.FDistant(this.FThreeArr);
         }
      }
      
      public function SetSilverCount() : void
      {
         this.FAlonePopFrame.SetSilverCount(this.silverTimes);
      }
      
      public function ZeroReset() : void
      {
         var _loc1_:int = 0;
         if(this.FBloodSoulBarVec.length == 0)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < NUM_TAB)
         {
            this.FBloodSoulBarVec[_loc1_].GlodTimers = 0;
            _loc1_++;
         }
         this.silverTimes = 0;
         this.SetSilverCount();
      }
      
      public function GetCustomLayer(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.FShut = param1;
         this.FLayer = param2;
         this.Funit = param3;
         this.FcustomId = param4;
      }
      
      public function GetCustomLayerCopy() : void
      {
         var _loc1_:int = 0;
         if(!this.FThreeArr.length)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < NUM_TAB)
         {
            if(this.FShut >= _loc1_)
            {
               if(this.getCurId(this.FThreeArr[_loc1_].SoulId) >= this.FFMore_High)
               {
                  this.FBloodSoulBarVec[_loc1_].Judge = 1;
                  this.FBloodSoulBarVec[_loc1_].IsOpen = false;
               }
               else
               {
                  if(this.getCustomId(this.FThreeArr[_loc1_].SoulId) == 0)
                  {
                     this.FBloodSoulBarVec[_loc1_].Judge = 4;
                  }
                  else if(SLogicsCore.Character.GetMainLevel() >= this.getCustomNeedLv(this.FThreeArr[_loc1_].SoulId))
                  {
                     this.FBloodSoulBarVec[_loc1_].Judge = 0;
                  }
                  else
                  {
                     this.FBloodSoulBarVec[_loc1_].Judge = 2;
                  }
                  this.FBloodSoulBarVec[_loc1_].IsOpen = true;
               }
            }
            else
            {
               this.FBloodSoulBarVec[_loc1_].Judge = 3;
               this.FBloodSoulBarVec[_loc1_].IsOpen = false;
            }
            _loc1_++;
         }
      }
      
      public function GetCustomLayerLittle() : void
      {
         if(!this.FThreeArr.length)
         {
            return;
         }
         if(this.getCurId(this.FThreeArr[this.FAtWhere].SoulId) >= this.FFMore_High)
         {
            this.FBloodSoulBarVec[this.FAtWhere].Judge = 1;
            this.FBloodSoulBarVec[this.FAtWhere].IsOpen = false;
         }
         else
         {
            if(this.getCustomId(this.FThreeArr[this.FAtWhere].SoulId) == 0)
            {
               this.FBloodSoulBarVec[this.FAtWhere].Judge = 4;
            }
            else if(SLogicsCore.Character.GetMainLevel() >= this.getCustomNeedLv(this.FThreeArr[this.FAtWhere].SoulId))
            {
               this.FBloodSoulBarVec[this.FAtWhere].Judge = 0;
            }
            else
            {
               this.FBloodSoulBarVec[this.FAtWhere].Judge = 2;
            }
            this.FBloodSoulBarVec[this.FAtWhere].IsOpen = true;
         }
      }
      
      public function getCustomId(param1:int) : int
      {
         var _loc2_:TBloodSoul_Attr = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr,param1) as TBloodSoul_Attr;
         return _loc2_.NeedBlock;
      }
      
      public function getCustomNeedLv(param1:int) : int
      {
         var _loc2_:TBloodSoul_Attr = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr,param1) as TBloodSoul_Attr;
         return _loc2_.NeedLevel;
      }
      
      public function getCurId(param1:int) : int
      {
         var _loc2_:TBloodSoul_Attr = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr,param1) as TBloodSoul_Attr;
         return _loc2_.Level;
      }
      
      public function getCustomType(param1:int) : int
      {
         var _loc2_:TBloodSoul_Attr = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr,param1) as TBloodSoul_Attr;
         if(_loc2_ == null)
         {
            return 1;
         }
         return _loc2_.Type;
      }
      
      public function getCustomName(param1:int, param2:int) : String
      {
         var _loc3_:TBloodSoul_Attr = null;
         var _loc4_:TBloodSoul_battle = null;
         var _loc5_:String = null;
         if(param1 == 0)
         {
            return "0";
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr,param1) as TBloodSoul_Attr;
         if(_loc3_.NeedBlock == 0)
         {
            param1++;
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr,param1) as TBloodSoul_Attr;
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Battle,_loc3_.NeedBlock) as TBloodSoul_battle;
         switch(param2)
         {
            case 0:
               _loc5_ = _loc4_.Name;
               break;
            case 1:
               _loc5_ = String(_loc4_.SStage + 1);
               break;
            case 2:
               _loc5_ = _loc4_.BossName;
               break;
            case 3:
               _loc5_ = String(_loc4_.Location);
         }
         return _loc5_;
      }
      
      public function getPrice(param1:int) : int
      {
         var _loc2_:TBloodSoul_Attr = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr,param1) as TBloodSoul_Attr;
         return _loc2_.NeedSilver;
      }
      
      public function BloodSoulCloseBtn(param1:MouseEvent) : void
      {
         if(this.FBloodSoulCloseBtnFun != null)
         {
            this.FBloodSoulCloseBtnFun(0);
         }
      }
      
      public function set BloodSoulCloseBtnFun(param1:Function) : void
      {
         this.FBloodSoulCloseBtnFun = param1;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(!this.FMcPanel)
         {
            return;
         }
         this.FMcPanel.visible = param1;
      }
      
      public function FAlonePopFrameF(param1:Object, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:AlonePopFrame = null;
         var _loc5_:uint = 0;
         var _loc6_:Boolean = false;
         var _loc7_:uint = 0;
         this.FSelectType = param2;
         if(this.FAlonePopFrame.IsCanUse)
         {
            if(this.FBloodSoulBarVec[this.FAtWhere].Judge == 2)
            {
               if(this.FThreeArr[this.FAtWhere].SoulId == 0)
               {
                  return;
               }
               _loc7_ = uint(this.getCustomNeedLv(this.FThreeArr[this.FAtWhere].SoulId));
               this.FUIWindowNotify.Visible = true;
               if(_loc7_ < CONST_COMMON.Ninja_One_Reincarnation_Footstone)
               {
                  this.FUIWindowNotify.Text = TUtilityString.Format(STRING_TONGLING.TONGLING_78,_loc7_);
               }
               else
               {
                  this.FUIWindowNotify.Text = TUtilityString.Format(STRING_TONGLING.TONGLING_79,STRING_COMMON.GetLevelStrByLevelLineFeed(_loc7_));
               }
            }
            else if(this.FBloodSoulBarVec[this.FAtWhere].Judge == 4)
            {
               if(this.FThreeArr[this.FAtWhere].SoulId == 0)
               {
                  return;
               }
               this.FUIWindowConfirmation.Visible = true;
               this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_TONGLING.TONGLING_35,this.getCustomName(this.FThreeArr[this.FAtWhere].SoulId,0),this.getCustomName(this.FThreeArr[this.FAtWhere].SoulId,1),this.getCustomName(this.FThreeArr[this.FAtWhere].SoulId,2));
            }
            else if(param2 != 1)
            {
               this.FSelectInventoryCount = this.FSelectInventories.GetAllCountByTempletID(this.TArt.Identifier);
               this.FCurInventoryCount = this.FSelectInventories.GetAllCountByTempletID(InventoryItemId[this.FAtWhere]);
               if(this.FUIWindowInformation.IsSelected)
               {
                  if(this.FBeforHasItem)
                  {
                     if(this.FSelectInventoryCount + this.FCurInventoryCount < (param2 == 2 ? 1 : this.FBloodSoulCount))
                     {
                        _loc6_ = true;
                        this.FUIWindowInformation.SetSelectedOrNot(false);
                        this.FUIWindowInformation.IsSelected = false;
                     }
                     else
                     {
                        _loc6_ = false;
                     }
                  }
                  else
                  {
                     _loc6_ = false;
                  }
               }
               else
               {
                  _loc6_ = true;
               }
               this.FBeforHasItem = Boolean(this.FSelectInventoryCount + this.FCurInventoryCount > 0);
               if(_loc6_)
               {
                  this.FUIWindowInformation.Visible = true;
                  _loc4_ = param1 as AlonePopFrame;
                  _loc5_ = uint(_loc4_.GoldTimes);
                  if(param2 == 2)
                  {
                     if(_loc5_ >= this.FGoldPuergatoryArr.length)
                     {
                        _loc5_ = this.FGoldPuergatoryArr.length - 1;
                     }
                     _loc3_ = TUtilityString.Format(STRING_TONGLING.TONGLING_30,this.FGoldPuergatoryArr[_loc5_],STRING_INHERITPRACTICE.INHERIT_GOLD,1,STRING_COMMON.STRING_BloodSoul[_loc4_.BooldType],1,this.TArt.Name,this.FSelectInventoryCount);
                  }
                  else
                  {
                     _loc3_ = TUtilityString.Format(STRING_TONGLING.TONGLING_30,this.getConsumeGold(_loc5_),STRING_INHERITPRACTICE.INHERIT_GOLD,this.FBloodSoulCount,STRING_COMMON.STRING_BloodSoul[_loc4_.BooldType],this.FBloodSoulCount,this.TArt.Name,this.FSelectInventoryCount);
                  }
                  this.FUIWindowInformation.Text = _loc3_;
               }
               else
               {
                  this.WindowInformationOnOK(this);
               }
            }
            else
            {
               this.WindowInformationOnOK(this);
            }
         }
         else if(this.FBloodSoulBarVec[this.FAtWhere].Judge == 1)
         {
            EffectGenerateText(STRING_TONGLING.TONGLING_34);
         }
         else
         {
            EffectGenerateText(STRING_TONGLING.TONGLING_33);
         }
      }
      
      public function set GoToBloodPurgatoryPanel(param1:Function) : void
      {
         this.FGoToBloodPurgatoryPanel = param1;
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         if(this.FGoToBloodPurgatoryPanel != null)
         {
            this.FGoToBloodPurgatoryPanel(this.getCustomName(this.FThreeArr[this.FAtWhere].SoulId,3));
         }
      }
      
      protected function getConsumeGold(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FBloodSoulCount)
         {
            _loc4_ = param1 + _loc2_;
            if(_loc4_ >= this.FGoldPuergatoryArr.length)
            {
               _loc4_ = this.FGoldPuergatoryArr.length - 1;
            }
            _loc3_ += this.FGoldPuergatoryArr[_loc4_];
            _loc2_++;
         }
         return _loc3_;
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         this.FAlonePopBackFunc(this.FAtWhere,this.FSelectType);
      }
      
      public function FBtnOverBackFuncF(param1:int, param2:int, param3:int) : void
      {
         this.FBtnOverBackFunc(param1,param2,param3,this.FPrice);
      }
      
      public function FBtnMoveBackFuncF(param1:int, param2:int) : void
      {
         this.FBtnMoveBackFunc(param1,param2);
      }
      
      public function FBtnOutBackFuncF(param1:int, param2:int) : void
      {
         this.FBtnOutBackFunc(param1,param2);
      }
      
      public function set AlonePopBackFunc(param1:Function) : void
      {
         this.FAlonePopBackFunc = param1;
      }
      
      public function set BtnOverBackFunc(param1:Function) : void
      {
         this.FBtnOverBackFunc = param1;
      }
      
      public function set BtnMoveBackFunc(param1:Function) : void
      {
         this.FBtnMoveBackFunc = param1;
      }
      
      public function set BtnOutBackFunc(param1:Function) : void
      {
         this.FBtnOutBackFunc = param1;
      }
      
      public function set Distant(param1:Function) : void
      {
         this.FDistant = param1;
      }
   }
}

