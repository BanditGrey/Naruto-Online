package Processors.Game.Lobby.Pet
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TBasePet;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TPetImage;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Pet.TPet;
   import Logics.SLogicsCore;
   import Logics.Vip.TVip;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Pet.Component.TBarVeryGood;
   import Processors.Game.Lobby.Pet.Component.TUIPetBigIcon;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PET;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_PET;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowPetLevel extends TProcessorLobbyWindow
   {
      
      public static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      protected static const ExpBallNum:uint = CONST_PET.BallNum;
      
      protected static const STRING_Capacity:String = CONST_COMMON.STRING_Capacity;
      
      protected static const TEMPNUMBER:uint = 18100000;
      
      protected static const STAR_NUMBER:uint = 10;
      
      protected static const ConsumeSilverCoin:uint = 15000;
      
      protected static const ConsumeGold:uint = 10;
      
      protected static const INFORMATION_OPEN:uint = 1;
      
      protected static const INFORMATION_CLOSE:uint = 8;
      
      protected static const INFORMATION_OPEN_STOP:uint = 7;
      
      protected static const INFORMATION_CLOSE_STOP:uint = 14;
      
      protected static const BATCH_LIMIT:uint = 6;
      
      protected static const RENDERINGSTATE_DISABLED:int = 4;
      
      protected static const BIG_ICON_INDEX:int = 2;
      
      protected static const FPsychicReel:uint = CONST_INVENTORY.CATEGORYSECOND_PsychicReel;
      
      protected var FHint:THint;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FMC_BigIcon:Sprite;
      
      protected var FMC_UpLevel:Sprite;
      
      protected var FMC_UpGrade:Sprite;
      
      protected var FMC_Character:Sprite;
      
      protected var FTF_Rate:TextField;
      
      protected var FMC_Relax:MovieClip;
      
      protected var FTF_Relax:TextField;
      
      protected var FMC_Summary:MovieClip;
      
      protected var FMC_Information:MovieClip;
      
      protected var FTF_Information:TextField;
      
      protected var FTF_Power:TextField;
      
      protected var FTF_Agile:TextField;
      
      protected var FTF_Intelligence:TextField;
      
      protected var FTF_HP:TextField;
      
      protected var FTF_FruitPower:TextField;
      
      protected var FTF_FruitAgile:TextField;
      
      protected var FTF_FruitIntelligence:TextField;
      
      protected var FTF_FruitHP:TextField;
      
      protected var FTF_PowerPluse:TextField;
      
      protected var FTF_AgilePluse:TextField;
      
      protected var FTF_IntelligencePluse:TextField;
      
      protected var FTF_RemainNum:TextField;
      
      protected var FTF_ItemName:TextField;
      
      protected var FTF_HPPluse:TextField;
      
      protected var FMC_BTs:Sprite;
      
      protected var FBT_SilverCoin:MovieClip;
      
      protected var FBT_OneKeySilverCoin:MovieClip;
      
      protected var FBT_Gold:MovieClip;
      
      protected var FBT_Batch:MovieClip;
      
      protected var FBT_Change:MovieClip;
      
      protected var FTF_LevelLimit:TextField;
      
      protected var FMC_LevelLimit:MovieClip;
      
      protected var FMC_ExpBar:Sprite;
      
      protected var FTF_Exp:TextField;
      
      protected var FTF_Level_1:TextField;
      
      protected var FMC_Level_2:MovieClip;
      
      protected var FMC_ExpBlueBar:Sprite;
      
      protected var FMC_Attr:MovieClip;
      
      protected var FBTs:Vector.<MovieClip>;
      
      protected var FBallNum:uint;
      
      protected var FMC_Name:MovieClip;
      
      protected var FMC_Name_Text:TextField;
      
      protected var FPetImage:TPetImage;
      
      protected var FPet:TPet;
      
      protected var FCharacter:TCharacter;
      
      protected var FBasePet:TBasePet;
      
      protected var FInformationOrNot:Boolean;
      
      protected var FUIBigIcon:TUIPetBigIcon;
      
      protected var FType:uint;
      
      protected var FTimes:uint;
      
      protected var FGoldOnceBoo:Boolean;
      
      protected var FGoldBatchBoo:Boolean;
      
      protected var FIsButten:Boolean;
      
      protected var FVipData:TVip;
      
      protected var FNameStr:String;
      
      protected var FScrollBar0:TScrollBar = null;
      
      protected var FScrollBar1:TScrollBar = null;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOverPet:Function;
      
      protected var FHintOnOutPet:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FImageBin:TBins;
      
      protected var FPetBin:TBins;
      
      protected var FRoleModle:TBins;
      
      protected var FUpStar:Function;
      
      protected var FTrainPet:Function;
      
      protected var FRightBtn:MovieClip;
      
      protected var FRightText:TextField;
      
      protected var FRightIndex:int;
      
      protected var FLeftBtn:MovieClip;
      
      protected var FLeftText:TextField;
      
      protected var FLeftIndex:int;
      
      protected var FMC_WuLiao0:MovieClip;
      
      protected var FMC_WuLiao1:MovieClip;
      
      protected var FRightList:MovieClip;
      
      protected var FLefttList:MovieClip;
      
      protected var PiLiangJuHunText:TextField;
      
      protected var YiJianJuHunText:TextField;
      
      public function TProcessorWindowPetLevel(param1:TUIComponent)
      {
         super(param1);
         this.FPet = SLogicsCore.Character.Pet;
         this.FCharacter = SLogicsCore.Character;
         this.FVipData = this.FCharacter.VipData;
         this.FBTs = new Vector.<MovieClip>();
         this.FHint = new THint();
      }
      
      public static function MergeAddAttribute(param1:Array, param2:Array) : Array
      {
         var _loc3_:Array = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_[0] == param2[0])
            {
               _loc3_[1] += param2[1];
               return param1;
            }
         }
         param1.push([param2[0],param2[1]]);
         return param1;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PET.RESOURCESID_PET);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUIPetBigIcon = null;
         var _loc7_:MovieClip = null;
         var _loc8_:TextField = null;
         var _loc9_:Sprite = null;
         var _loc10_:TConfigValue = null;
         var _loc11_:TArticle = null;
         var _loc12_:int = 0;
         this.FMC_UpLevel = TUtilityReflection.CreateDisplayObjectInstance(CONST_PET.RESOURCE_Link_MC_UpLevel) as Sprite;
         this.addChild(this.FMC_UpLevel);
         this.FMC_UpGrade = this.FMC_UpLevel[CONST_PET.RESOURCE_Link_MC_UpGrade];
         this.FTF_RemainNum = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_TF_RemainNum];
         this.FTF_ItemName = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_TF_ItemName];
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.PET_QUICK_ITEM) as TConfigValue;
         _loc12_ = _loc10_.Value as int;
         _loc11_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc12_) as TArticle;
         this.FNameStr = _loc11_.Name;
         this.FTF_ItemName.text = this.FNameStr;
         this.FTF_ItemName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc11_.Quality];
         this.FMC_Name = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_MC_Name] as MovieClip;
         this.FMC_Name_Text = this.FMC_Name["TF_name"];
         this.FMC_Relax = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_MC_Relax];
         TGameUtil.setButtonMode(this.FMC_Relax,true);
         this.FBTs.push(this.FMC_Relax);
         this.FTF_Relax = this.FMC_Relax[CONST_PET.RESOURCE_Link_TF_Relax];
         this.FTF_Relax.mouseEnabled = false;
         this.FMC_Summary = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_MC_Summary];
         TGameUtil.setButtonMode(this.FMC_Summary,true);
         this.FMC_Information = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_MC_Information];
         this.FTF_Information = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_TF_Information];
         this.FTF_Information.visible = false;
         this.FMC_Character = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_MC_Character];
         this.FTF_Rate = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_Rate];
         this.FTF_Power = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_Power];
         this.FTF_Agile = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_Agile];
         this.FTF_Intelligence = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_Intelligence];
         this.FTF_HP = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_HP];
         this.FTF_FruitPower = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_FruitPower];
         this.FTF_FruitAgile = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_FruitAgile];
         this.FTF_FruitIntelligence = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_FruitIntelligence];
         this.FTF_FruitHP = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_FruitHP];
         this.FTF_PowerPluse = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_PowerPluse];
         this.FTF_AgilePluse = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_AgilePluse];
         this.FTF_IntelligencePluse = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_IntelligencePluse];
         this.FTF_HPPluse = this.FMC_Character[CONST_PET.RESOURCE_Link_TF_HPPluse];
         this.FMC_BTs = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_MC_BTs];
         this.FMC_Attr = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_MC_Attr];
         this.FBT_SilverCoin = this.FMC_BTs[CONST_PET.RESOURCE_Link_BT_SilverCoin];
         this.FBT_OneKeySilverCoin = this.FMC_BTs["MC_Medill_0"][CONST_PET.RESOURCE_Link_BT_OneKeySilverCoin];
         this.PiLiangJuHunText = this.FBT_OneKeySilverCoin["TF_NiMei"];
         this.FBT_Gold = this.FMC_BTs[CONST_PET.RESOURCE_Link_BT_Gold];
         this.FBT_Batch = this.FMC_BTs["MC_Medill_1"][CONST_PET.RESOURCE_Link_BT_Batch];
         this.YiJianJuHunText = this.FBT_Batch["TF_NiMei"];
         this.FBT_Change = this.FMC_BTs[CONST_PET.RESOURCE_Link_BT_Change];
         TGameUtil.setButtonMode(this.FBT_SilverCoin,true);
         TGameUtil.setButtonMode(this.FBT_OneKeySilverCoin,true);
         TGameUtil.setButtonMode(this.FBT_Gold,true);
         TGameUtil.setButtonMode(this.FBT_Change,true);
         this.FBTs.push(this.FBT_SilverCoin);
         this.FBTs.push(this.FBT_OneKeySilverCoin);
         this.FBTs.push(this.FBT_Gold);
         this.FBTs.push(this.FBT_Batch);
         this.FBTs.push(this.FBT_Change);
         this.FBT_Change.visible = false;
         this.FMC_WuLiao0 = this.FMC_BTs["MC_Medill_0"]["MC_WuLiao"];
         this.FMC_WuLiao1 = this.FMC_BTs["MC_Medill_1"]["MC_WuLiao"];
         this.FLefttList = this.FMC_WuLiao0["mc_list"];
         this.FScrollBar0 = new TScrollBar(this.FLefttList,39,true,0);
         this.FScrollBar0.Clear();
         this.FLeftBtn = this.FMC_WuLiao0["mc_bar"]["MC_Btn"];
         this.FLeftBtn.buttonMode = true;
         this.FLeftText = this.FMC_WuLiao0["mc_bar"]["TF_text"];
         this.FRightList = this.FMC_WuLiao1["mc_list"];
         this.FScrollBar1 = new TScrollBar(this.FRightList,39,true,0);
         this.FScrollBar1.Clear();
         this.FRightBtn = this.FMC_WuLiao1["mc_bar"]["MC_Btn"];
         this.FRightBtn.buttonMode = true;
         this.FRightText = this.FMC_WuLiao1["mc_bar"]["TF_text"];
         this.FMC_LevelLimit = this.FMC_BTs[CONST_PET.RESOURCE_Link_MC_LevelLimite];
         this.FTF_LevelLimit = this.FMC_LevelLimit[CONST_PET.RESOURCE_Link_TF_LevelLimite];
         this.FMC_LevelLimit.visible = false;
         this.FTF_LevelLimit.mouseEnabled = false;
         this.FMC_ExpBar = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_MC_ExpBar];
         this.FTF_Exp = this.FMC_ExpBar[CONST_PET.RESOURCE_Link_TF_Exp];
         this.FTF_Level_1 = this.FMC_ExpBar[CONST_PET.RESOURCE_Link_TF_Level_1];
         this.FMC_Level_2 = this.FMC_ExpBar[CONST_PET.RESOURCE_Link_MC_Level_2];
         this.FMC_ExpBlueBar = this.FMC_ExpBar[CONST_PET.RESOURCE_Link_MC_ExpBlueBar];
         this.FMC_BigIcon = this.FMC_UpGrade[CONST_PET.RESOURCE_Link_MC_BigIcon];
         this.FMC_BigIcon.mouseEnabled = false;
         this.FUIBigIcon = new TUIPetBigIcon(this);
         this.FUIBigIcon.mouseEnabled = false;
         this.FMC_BigIcon.addChild(this.FUIBigIcon);
         this.FUIBigIcon.OnQuerySequenceContext = this.PetIconOnQuerySequenceContext;
         this.FUIBigIcon.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowInformation.SetCheckBox(true);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc4_:TBarVeryGood = null;
         this.FBT_SilverCoin.addEventListener(MouseEvent.CLICK,this.Train);
         this.FBT_SilverCoin.addEventListener(MouseEvent.MOUSE_MOVE,this.SilverCoinOnOver);
         this.FBT_SilverCoin.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         this.FBT_OneKeySilverCoin.addEventListener(MouseEvent.CLICK,this.Train);
         this.FBT_OneKeySilverCoin.addEventListener(MouseEvent.MOUSE_MOVE,this.SilverCoinOnOver);
         this.FBT_OneKeySilverCoin.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         this.FBT_Gold.addEventListener(MouseEvent.CLICK,this.Train);
         this.FBT_Gold.addEventListener(MouseEvent.MOUSE_MOVE,this.GoldOnOver);
         this.FBT_Gold.addEventListener(MouseEvent.MOUSE_OUT,this.GoldOnOut);
         this.FBT_Batch.addEventListener(MouseEvent.CLICK,this.Train);
         this.FBT_Batch.addEventListener(MouseEvent.MOUSE_MOVE,this.BatchOnOver);
         this.FBT_Batch.addEventListener(MouseEvent.MOUSE_OUT,this.GoldOnOut);
         this.FBT_Change.addEventListener(MouseEvent.CLICK,this.Unlock);
         this.FBT_Change.addEventListener(MouseEvent.MOUSE_MOVE,this.ChangeOnOver);
         this.FBT_Change.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         this.FMC_Summary.addEventListener(MouseEvent.CLICK,this.OpenInformation);
         this.FMC_Relax.addEventListener(MouseEvent.CLICK,this.OnRelex);
         this.FLeftBtn.addEventListener(MouseEvent.CLICK,this.LittlBtnClick);
         this.FRightBtn.addEventListener(MouseEvent.CLICK,this.LittlBtnClick);
         this.FLeftBtn.addEventListener(MouseEvent.MOUSE_OVER,this.LittlBtnOver);
         this.FLeftBtn.addEventListener(MouseEvent.MOUSE_OUT,this.LittlBtnOut);
         this.FLeftBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.LittlBtnDown);
         this.FLeftBtn.addEventListener(MouseEvent.MOUSE_UP,this.LittlBtnOut);
         this.FRightBtn.addEventListener(MouseEvent.MOUSE_OVER,this.LittlBtnOver);
         this.FRightBtn.addEventListener(MouseEvent.MOUSE_OUT,this.LittlBtnOut);
         this.FRightBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.LittlBtnDown);
         this.FRightBtn.addEventListener(MouseEvent.MOUSE_UP,this.LittlBtnOut);
         var _loc2_:Vector.<uint> = STRING_PET.STRING_PetNum;
         var _loc3_:int = int(_loc2_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc4_ = new TBarVeryGood(_loc2_[_loc1_],_loc1_);
            _loc4_.BackFunc = this.LeftBtnBackFunc;
            this.FScrollBar0.AddItem(_loc4_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc4_ = new TBarVeryGood(_loc2_[_loc1_],_loc1_);
            _loc4_.BackFunc = this.RightBtnBackFunc;
            this.FScrollBar1.AddItem(_loc4_);
            _loc1_++;
         }
         this.FScrollBar0.ScrollToUp();
         this.FScrollBar1.ScrollToUp();
         this.FScrollBar0.SetScrollVisble(false);
         this.FScrollBar1.SetScrollVisble(false);
         this.FRightList.visible = false;
         this.FLefttList.visible = false;
         this.UpdateNumText();
         super.ResourcesPerform_UILocations();
      }
      
      protected function LittlBtnOver(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(2);
      }
      
      protected function LittlBtnOut(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(1);
      }
      
      protected function LittlBtnDown(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(3);
      }
      
      public function UpdateNumText() : void
      {
         var _loc1_:int = 0;
         var _loc3_:TBarVeryGood = null;
         var _loc2_:String = "";
         _loc2_ = String(STRING_PET.STRING_PetNum[this.FLeftIndex]);
         this.FLeftText.text = _loc2_;
         this.PiLiangJuHunText.text = TUtilityString.Format(STRING_PET.STRING_Fuck,_loc2_);
         _loc2_ = String(STRING_PET.STRING_PetNum[this.FRightIndex]);
         this.FRightText.text = _loc2_;
         this.YiJianJuHunText.text = TUtilityString.Format(STRING_PET.STRING_Fuck,_loc2_);
         _loc1_ = 0;
         while(_loc1_ < this.FScrollBar0.Count)
         {
            _loc3_ = this.FScrollBar0.Items[_loc1_] as TBarVeryGood;
            _loc3_.Update();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FScrollBar1.Count)
         {
            _loc3_ = this.FScrollBar1.Items[_loc1_] as TBarVeryGood;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function OpenPanelInitilization() : void
      {
         this.LeftBtnBackFunc(0);
         this.RightBtnBackFunc(0);
      }
      
      protected function LeftBtnBackFunc(param1:int) : void
      {
         this.FScrollBar0.SetScrollVisble(false);
         this.FLefttList.visible = false;
         this.FLeftIndex = param1;
         this.UpdateNumText();
      }
      
      protected function RightBtnBackFunc(param1:int) : void
      {
         this.FScrollBar1.SetScrollVisble(false);
         this.FRightList.visible = false;
         this.FRightIndex = param1;
         this.UpdateNumText();
      }
      
      protected function LittlBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         switch(param1.currentTarget)
         {
            case this.FLeftBtn:
               _loc2_ = this.FLefttList.visible == true ? false : true;
               this.FScrollBar0.SetScrollVisble(_loc2_);
               if(_loc2_)
               {
                  this.FScrollBar1.SetScrollVisble(!_loc2_);
                  this.FRightList.visible = !_loc2_;
               }
               this.FLefttList.visible = _loc2_;
               break;
            case this.FRightBtn:
               _loc2_ = this.FRightList.visible == true ? false : true;
               this.FScrollBar1.SetScrollVisble(_loc2_);
               if(_loc2_)
               {
                  this.FScrollBar0.SetScrollVisble(!_loc2_);
                  this.FLefttList.visible = !_loc2_;
               }
               this.FRightList.visible = _loc2_;
         }
         this.UpdateNumText();
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FUIBigIcon != null)
         {
            this.FUIBigIcon.Update();
         }
         super.LogicsPerform();
      }
      
      public function SetBtDisable(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.FBTs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            TGameUtil.LockOrUnlockButton(this.FBTs[_loc2_],param1);
            _loc2_++;
         }
      }
      
      protected function OnRelex(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RelaxOrNotRequest);
         _loc3_ = _loc2_.Data;
         if(this.FPet.RelexBoo == false)
         {
            _loc4_ = 0;
         }
         else
         {
            _loc4_ = 1;
         }
         this.FPet.RelexBoo = !this.FPet.RelexBoo;
         _loc3_.writeByte(_loc4_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.SetBtDisable(false);
      }
      
      protected function OpenInformation(param1:MouseEvent) : void
      {
         this.FInformationOrNot = !this.FInformationOrNot;
         if(this.FInformationOrNot)
         {
            this.FMC_Information.gotoAndPlay(INFORMATION_OPEN);
         }
         else
         {
            this.FMC_Information.gotoAndPlay(INFORMATION_CLOSE);
            this.FTF_Information.visible = false;
         }
         this.FMC_Information.addEventListener(Event.ENTER_FRAME,this.OnFrame);
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         if(this.FTrainPet != null)
         {
            this.FTrainPet(this.FType,this.FTimes);
         }
         this.FPet.TrainTimes = this.FTimes;
         this.SetBtDisable(false);
      }
      
      protected function Train(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventory = null;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TBasePet = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:TConfigValue = null;
         if(SLogicsCore.Character.MaxTempValue)
         {
            return;
         }
         _loc2_ = this.FCharacter.CreditGold;
         _loc3_ = this.FCharacter.CreditGiftCertificate;
         _loc8_ = this.FCharacter.Appliances;
         _loc7_ = uint(_loc8_.Count);
         _loc5_ = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc4_ = _loc8_.GetInventoryByIndex(_loc6_);
            if(_loc4_.CategorySecond == FPsychicReel)
            {
               _loc5_ += _loc4_.Quantity;
            }
            _loc6_++;
         }
         switch(param1.target)
         {
            case this.FBT_SilverCoin:
               if(this.FCharacter.CreditSilverCoin.ToNumber() >= ConsumeSilverCoin)
               {
                  this.FType = 1;
                  this.FTimes = 1;
               }
               else
               {
                  EffectGenerateText(STRING_COMMON.NOTENOUGH_Coin);
                  this.FType = 0;
                  this.FTimes = 0;
               }
               break;
            case this.FBT_OneKeySilverCoin:
               _loc11_ = STRING_PET.STRING_PetNum[this.FLeftIndex];
               if(this.FCharacter.CreditSilverCoin.ToNumber() >= ConsumeSilverCoin * _loc11_)
               {
                  this.FType = 1;
                  this.FTimes = _loc11_;
               }
               else
               {
                  EffectGenerateText(STRING_COMMON.NOTENOUGH_Coin);
                  this.FType = 0;
                  this.FTimes = 0;
               }
               break;
            case this.FBT_Gold:
               if(_loc5_ * 10 + _loc2_ + _loc3_ >= ConsumeGold)
               {
                  this.FType = 2;
                  this.FTimes = 1;
                  if(this.FGoldBatchBoo && this.FGoldOnceBoo == false)
                  {
                     this.FUIWindowInformation.IsSelected = false;
                     this.FUIWindowInformation.SetSelectedOrNot(this.FUIWindowInformation.IsSelected);
                  }
                  if(!this.FUIWindowInformation.IsSelected)
                  {
                     _loc9_ = this.FPetBin.GetDatebaseByIdentifier(this.FPet.PetID) as TBasePet;
                     _loc10_ = uint(_loc9_.GoldExp);
                     this.FUIWindowInformation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Pet_AdvCulture).DescribeString,10,_loc10_,10);
                     this.FUIWindowInformation.Visible = true;
                     this.FGoldOnceBoo = true;
                     return;
                  }
                  this.FGoldOnceBoo = true;
               }
               else
               {
                  this.FUIWindowRecharge.Visible = true;
                  this.FType = 0;
                  this.FTimes = 0;
               }
               break;
            case this.FBT_Batch:
               if(!this.FVipData.OneTimePet)
               {
                  return;
               }
               _loc11_ = STRING_PET.STRING_PetNum[this.FRightIndex];
               if(_loc5_ * 10 + _loc2_ + _loc3_ >= _loc11_ * ConsumeGold)
               {
                  this.FType = 2;
                  this.FTimes = _loc11_;
                  if(this.FGoldOnceBoo && this.FGoldBatchBoo == false)
                  {
                     this.FUIWindowInformation.IsSelected = false;
                     this.FGoldBatchBoo = true;
                  }
                  if(!this.FUIWindowInformation.IsSelected)
                  {
                     _loc9_ = this.FPetBin.GetDatebaseByIdentifier(this.FPet.PetID) as TBasePet;
                     _loc10_ = _loc9_.GoldExp * _loc11_;
                     this.FUIWindowInformation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Pet_AdvCulture_All).DescribeString,_loc11_ * ConsumeGold,_loc11_,10);
                     this.FUIWindowInformation.SetSelectedOrNot(this.FUIWindowInformation.IsSelected);
                     this.FUIWindowInformation.Visible = true;
                     this.FGoldBatchBoo = true;
                     return;
                  }
                  this.FGoldBatchBoo = true;
               }
               else
               {
                  this.FUIWindowRecharge.Visible = true;
                  this.FType = 0;
                  this.FTimes = 0;
               }
         }
         if(this.FType != 0 && this.FTimes != 0)
         {
            if(this.FTrainPet != null)
            {
               this.FTrainPet(this.FType,this.FTimes);
            }
            this.FPet.TrainTimes = this.FTimes;
            this.SetBtDisable(false);
         }
         TutorialNextStep(901);
      }
      
      protected function SilverCoinOnOver(param1:MouseEvent) : void
      {
         if(param1.currentTarget == this.FBT_SilverCoin)
         {
            this.FHint.Caption = STRING_PET.STRING_SilverCoinTrain;
         }
         else
         {
            if(param1.currentTarget != this.FBT_OneKeySilverCoin)
            {
               return;
            }
            this.FHint.Caption = STRING_PET.STRING_OneKeySilverCoinTrainCopy[this.FLeftIndex];
         }
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function OnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function GoldOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOutPet != null)
         {
            this.FHintOnOutPet(this);
         }
      }
      
      protected function GoldOnOver(param1:MouseEvent) : void
      {
         this.FHint.Caption = TUtilityString.Format(STRING_PET.STRING_GoldTrain,this.FNameStr);
         if(this.FHintOnOverPet != null)
         {
            this.FHintOnOverPet(this,this.FHint);
         }
      }
      
      protected function BatchOnOver(param1:MouseEvent) : void
      {
         this.FHint.Caption = TUtilityString.Format(STRING_PET.STRING_BatchTrainCopy[this.FRightIndex],this.FNameStr);
         if(this.FHintOnOverPet != null)
         {
            this.FHintOnOverPet(this,this.FHint);
         }
      }
      
      protected function ChangeOnOver(param1:MouseEvent) : void
      {
         this.FHint.Caption = STRING_PET.STRING_Change;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function PetIconOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint) : void
      {
         var _loc5_:TPet = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TPet;
         _loc6_ = SResourcesCore.TexturesPet;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.PetBigImageID);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.PetBigImageID,CONST_MODULES.MODULE_Pet);
         }
      }
      
      protected function ExpUpdate() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         _loc4_ = this.FPet.PetID;
         this.FBasePet = this.FPetBin.GetDatebaseByIdentifier(_loc4_) as TBasePet;
         this.FPet.NeedExp = this.FBasePet.NeedExp;
         this.FPet.Star = this.FBasePet.Star;
         this.FPet.LevelLimit = this.FBasePet.LevelLimit;
         this.FPet.AddRate = this.FBasePet.AddRate;
         this.FPet.Images = this.FBasePet.ImagesVect;
         this.FPet.ReviceCount = this.FBasePet.ReviceCount;
         this.FPet.ReincarnationLevel = this.FBasePet.NeedTransLv;
         _loc3_ = this.FPet.CurrentExp;
         _loc2_ = this.FPet.NeedExp;
         this.FTF_Exp.text = TUtilityString.Format(STRING_Capacity,_loc3_,_loc2_);
         _loc1_ = _loc3_ / _loc2_;
         if(_loc1_ > 1)
         {
            _loc1_ = 1;
         }
         this.FMC_ExpBlueBar.scaleX = _loc1_;
         if(this.FPet.Star == STAR_NUMBER)
         {
            this.FTF_Level_1.visible = false;
            this.FMC_Level_2.visible = true;
            this.FMC_Level_2.gotoAndPlay(1);
            this.FTF_Exp.visible = false;
            this.ChangeBT();
         }
         else
         {
            this.FMC_Level_2.visible = false;
            _loc5_ = "";
            _loc5_ = TUtilityString.Format(STRING_PET.STRING_PetTip,int(this.FPet.PetID % 1000 / 100) + 1,this.FPet.Star);
            this.FTF_Level_1.text = _loc5_;
            this.FTF_Level_1.visible = true;
            this.FTF_Exp.visible = true;
         }
         if(this.FUpStar != null)
         {
            this.FUpStar(this);
         }
      }
      
      protected function ValueUpdate() : void
      {
         var _loc1_:TBasePet = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc4_ = uint(this.FBasePet.Power);
         this.FTF_Power.text = _loc4_.toString();
         this.FTF_FruitPower.text = "(+" + this.FPet.Power + ")";
         _loc4_ = uint(this.FBasePet.Agile);
         this.FTF_Agile.text = _loc4_.toString();
         this.FTF_FruitAgile.text = "(+" + this.FPet.Agile + ")";
         _loc4_ = uint(this.FBasePet.Intelligence);
         this.FTF_Intelligence.text = _loc4_.toString();
         this.FTF_FruitIntelligence.text = "(+" + this.FPet.Intelligence + ")";
         _loc4_ = uint(this.FBasePet.Life);
         this.FTF_HP.text = _loc4_.toString();
         this.FTF_FruitHP.text = "(+" + this.FPet.Life + ")";
         this.FTF_Rate.text = (this.FPet.AddRate * 100).toFixed(1) + "%";
         if(this.FPet.ReviceCount == 9 && this.FPet.Star == 10 && this.FPet.ReincarnationLevel == 3)
         {
            this.FTF_PowerPluse.text = this.FTF_AgilePluse.text = this.FTF_IntelligencePluse.text = this.FTF_HPPluse.text = "";
            this.FMC_BTs.visible = false;
            return;
         }
         _loc3_ = this.FBasePet.NextId;
         _loc1_ = this.FPetBin.GetDatebaseByIdentifier(_loc3_) as TBasePet;
         _loc2_ = _loc1_.Power - this.FBasePet.Power;
         this.FTF_PowerPluse.text = "+" + _loc2_.toString();
         _loc2_ = _loc1_.Agile - this.FBasePet.Agile;
         this.FTF_AgilePluse.text = "+" + _loc2_.toString();
         _loc2_ = _loc1_.Intelligence - this.FBasePet.Intelligence;
         this.FTF_IntelligencePluse.text = "+" + _loc2_.toString();
         _loc2_ = _loc1_.Life - this.FBasePet.Life;
         this.FTF_HPPluse.text = "+" + _loc2_.toString();
      }
      
      protected function ChangeBT() : void
      {
         this.FBT_Gold.visible = false;
         this.FBT_SilverCoin.visible = false;
         this.FBT_OneKeySilverCoin.visible = false;
         this.FMC_WuLiao0.visible = false;
         this.FBT_Batch.visible = false;
         this.FMC_WuLiao1.visible = false;
         if(this.FCharacter.MainHero.Level >= this.FPet.LevelLimit)
         {
            this.FBT_Change.visible = true;
            this.FMC_LevelLimit.visible = false;
         }
         else
         {
            this.FTF_LevelLimit.text = TUtilityString.Format(STRING_PET.FORMAT_LevelLimit,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(this.FPet.LevelLimit));
            this.FMC_LevelLimit.visible = true;
         }
      }
      
      protected function GetInformation(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         this.FPetImage = this.FImageBin.GetDatebaseByIdentifier(param1) as TPetImage;
         _loc3_ = this.FPetImage.Desc;
         this.FPet.Name = this.FPetImage.Name;
         _loc4_ = _loc3_.split("\\n");
         this.FTF_Information.text = _loc4_[0] + "\n\n" + _loc4_[1] + "\n" + _loc4_[2];
      }
      
      protected function Unlock(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_UnLuckRequest);
         if(this.FCharacter.MainHero.Level >= this.FPet.LevelLimit)
         {
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
            this.SetBtDisable(false);
         }
         else
         {
            EffectGenerateText(STRING_PET.STRING_MainHeroLevelNotEnough);
         }
      }
      
      protected function OnFrame(param1:Event) : void
      {
         if(this.FMC_Information.currentFrame == INFORMATION_OPEN_STOP)
         {
            this.FMC_Information.removeEventListener(Event.ENTER_FRAME,this.OnFrame);
            this.FTF_Information.visible = true;
         }
         if(this.FMC_Information.currentFrame == INFORMATION_CLOSE_STOP)
         {
            this.FMC_Information.removeEventListener(Event.ENTER_FRAME,this.OnFrame);
         }
      }
      
      protected function GetName(param1:uint) : void
      {
         var _loc2_:TPetImage = null;
         var _loc3_:TRoleModel = null;
         _loc2_ = this.FImageBin.GetDatebaseByIdentifier(param1) as TPetImage;
         this.FPet.Name = _loc2_.Name;
         _loc3_ = this.FRoleModle.GetDatebaseByIdentifier(param1) as TRoleModel;
         this.FPet.SmallIcon = _loc3_.RoleHead;
         this.FPet.PetBigImageID = _loc3_.RoleStyle;
         this.FPet.PetModelID = _loc2_.Identifier;
      }
      
      protected function updateRemainNum() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventory = null;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TInventories = null;
         _loc1_ = this.FCharacter.CreditGold;
         _loc2_ = this.FCharacter.CreditGiftCertificate;
         _loc7_ = this.FCharacter.Appliances;
         _loc6_ = uint(_loc7_.Count);
         _loc4_ = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = _loc7_.GetInventoryByIndex(_loc5_);
            if(_loc3_.CategorySecond == FPsychicReel)
            {
               _loc4_ += _loc3_.Quantity;
            }
            _loc5_++;
         }
         this.FTF_RemainNum.text = TUtilityString.Format(STRING_PET.FORMAT_RemainNum,_loc4_);
      }
      
      protected function UpAttributeInfo() : void
      {
         var _loc1_:TBasePet = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         if(this.FPet)
         {
            _loc2_ = [];
            _loc5_ = "";
            for each(_loc6_ in this.FPet.UnlockPetIds)
            {
               _loc1_ = this.FPetBin.GetDatebaseByIdentifier(_loc6_) as TBasePet;
               if(_loc1_)
               {
                  for each(_loc7_ in _loc1_.SpecialArr)
                  {
                     MergeAddAttribute(_loc2_,_loc7_);
                  }
               }
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_];
               _loc5_ += this.AttributeFormat(_loc4_[0],_loc4_[1]) + "\n";
               _loc3_++;
            }
            this.FMC_Attr["TF_Attr"].text = _loc5_;
         }
      }
      
      protected function AttributeFormat(param1:int, param2:Number) : String
      {
         var _loc3_:int = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(param1);
         var _loc4_:String = "";
         if(_loc3_ != -1)
         {
            _loc4_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc3_];
         }
         if(param2 != 0)
         {
            if(param2 > 1)
            {
               return _loc4_ + " +" + param2;
            }
            return _loc4_ + " +" + (param2 * 100).toFixed(0) + "%";
         }
         return _loc4_;
      }
      
      protected function updateMCShow() : void
      {
         var _loc1_:TBasePet = null;
         _loc1_ = this.FPetBin.GetDatebaseByIdentifier(this.FPet.ImageID) as TBasePet;
         if(Boolean(_loc1_) && _loc1_.ItemArr.length > 0)
         {
            this.FMC_BTs.visible = false;
            this.FMC_ExpBar.visible = false;
         }
         else
         {
            this.FMC_BTs.visible = true;
            this.FMC_ExpBar.visible = true;
         }
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOverPet() : Function
      {
         return this.FHintOnOverPet;
      }
      
      public function set HintOnOverPet(param1:Function) : void
      {
         this.FHintOnOverPet = param1;
      }
      
      public function get HintOnOutPet() : Function
      {
         return this.FHintOnOutPet;
      }
      
      public function set HintOnOutPet(param1:Function) : void
      {
         this.FHintOnOutPet = param1;
      }
      
      public function get PetBin() : TBins
      {
         return this.FPetBin;
      }
      
      public function set PetBin(param1:TBins) : void
      {
         this.FPetBin = param1;
      }
      
      public function get ImageBin() : TBins
      {
         return this.FImageBin;
      }
      
      public function set ImageBin(param1:TBins) : void
      {
         this.FImageBin = param1;
      }
      
      public function get UpStar() : Function
      {
         return this.FUpStar;
      }
      
      public function set UpStar(param1:Function) : void
      {
         this.FUpStar = param1;
      }
      
      public function get RoleModle() : TBins
      {
         return this.FRoleModle;
      }
      
      public function set RoleModle(param1:TBins) : void
      {
         this.FRoleModle = param1;
      }
      
      public function set PetRelax(param1:String) : void
      {
         this.FTF_Relax.text = param1;
      }
      
      public function get TrainPet() : Function
      {
         return this.FTrainPet;
      }
      
      public function set TrainPet(param1:Function) : void
      {
         this.FTrainPet = param1;
      }
      
      public function Init() : void
      {
         var _loc1_:uint = 0;
         this.ExpUpdate();
         this.updateMCShow();
         this.UpAttributeInfo();
         this.ValueUpdate();
         this.GetInformation(this.FPet.ImageID);
         if(this.FVipData.OneTimePet)
         {
            if(this.FPet.Star != STAR_NUMBER)
            {
               this.FBT_Batch.gotoAndStop(1);
            }
            if(!this.FIsButten)
            {
               TGameUtil.setButtonMode(this.FBT_Batch,true);
               this.FIsButten = true;
            }
         }
         else
         {
            this.FBT_Batch.gotoAndStop(RENDERINGSTATE_DISABLED);
         }
         this.GetName(this.FPet.ImageID);
         this.SetNameByPetId(this.FPet.PetID);
         this.FUIBigIcon.Context = this.FPet as TPet;
         this.FUIBigIcon.Frame = 2;
         this.FUIBigIcon.Update();
         if(this.FPet.RelexBoo)
         {
            this.PetRelax = STRING_PET.STRING_Used;
         }
         else
         {
            this.PetRelax = STRING_PET.STRING_UnUse;
         }
         this.updateRemainNum();
         this.OpenPanelInitilization();
      }
      
      public function ChangeBody() : void
      {
         var _loc1_:uint = 0;
         this.GetInformation(this.FPet.ImageID);
         this.GetName(this.FPet.ImageID);
         this.SetNameByPetId(this.FPet.PetID);
         this.updateMCShow();
         this.UpAttributeInfo();
         this.FUIBigIcon.Context = this.FPet as TPet;
         this.FUIBigIcon.Frame = 2;
         this.FUIBigIcon.Update();
      }
      
      public function Update() : void
      {
         this.ExpUpdate();
         this.ValueUpdate();
         this.updateRemainNum();
         this.LeftBtnBackFunc(this.FLeftIndex);
         this.RightBtnBackFunc(this.FRightIndex);
      }
      
      public function UnLuckUpdate() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         this.FBT_Gold.visible = true;
         this.FBT_SilverCoin.visible = true;
         this.FBT_OneKeySilverCoin.visible = true;
         this.FMC_WuLiao0.visible = true;
         this.FBT_Batch.visible = true;
         this.FMC_WuLiao1.visible = true;
         this.FBT_Change.visible = false;
         this.FMC_LevelLimit.visible = false;
         this.FPet.CurrentExp = 0;
         this.ExpUpdate();
         this.ValueUpdate();
         _loc1_ = this.FPet.Images[this.FPet.Images.length - 1];
         this.FPet.ImageID = _loc1_;
         this.GetInformation(_loc1_);
         this.GetName(_loc1_);
         this.SetNameByPetId(this.FPet.PetID);
         this.FUIBigIcon.Context = this.FPet as TPet;
         this.FUIBigIcon.Frame = 2;
      }
      
      public function SetNameByPetId(param1:uint) : void
      {
         var _loc2_:TBasePet = null;
         _loc2_ = this.FPetBin.GetDatebaseByIdentifier(this.FPet.ImageID) as TBasePet;
         if(Boolean(_loc2_) && _loc2_.ItemArr.length > 0)
         {
            param1 = uint(this.FPet.ImageID);
         }
         var _loc3_:TBasePet = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BasePet,param1) as TBasePet;
         this.FMC_Name_Text.text = _loc3_.Name;
      }
   }
}

